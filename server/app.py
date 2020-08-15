from flask import Flask, request, jsonify
from firebase_admin import credentials, firestore, initialize_app
import requests
from bs4 import BeautifulSoup
from googleapiclient.discovery import build
import argparse
from googleapiclient.errors import HttpError


app = Flask(__name__)

# Initialize Firestore DB
cred = credentials.Certificate('key.json')
default_app = initialize_app(cred)
db = firestore.client()
tasks_ref = db.collection('tasks')
orgs_ref = db.collection('organisations')

#For a single search
def GoogleTopResults(SearchQuery):
    q = SearchQuery.replace(' ', '+')
    URL = f"https://google.com/search?q={q}"

    resp = requests.get(URL)

    if (resp.status_code == 200):
        soup = BeautifulSoup(resp.content, "html.parser")

    a=soup.find_all('a')

    LINKS=[]

    for i in a:
        pos=0
        k = i.get('href')
        if(k.find("https")!=-1 and not(k.find("google")!=-1) and not(k.find("instagram.com")!=-1) and not(k.find("imgurl=")!=-1)):
            pos=k.find("&")
            link=k[7:pos]
            if(link not in LINKS):
                LINKS.append(link)
        if(len(LINKS)==3):
            break

    return LINKS

# For Google results
@app.route("/google", methods=['POST'])
def google():
    body = request.get_json()
    print("BODYY:", body)
    keyword = body['skills']
    print("GET YO SKILLS", keyword)
    keyword = keyword.split(',')
    print("KEYWORDDD:",type(keyword), keyword)

    #edit code
    all_links=[]
    arr=[]
    for i in keyword:
        arr=GoogleTopResults(i)
        for j in range(len(arr)):
            all_links.append(arr[j])
    print(all_links)
    print("Printing responsee")
    print(jsonify({"links": all_links}))
    return jsonify({"links": all_links})


#For a single search
def YoutubeTopResults(SearchQuery):
    api_key = 'AIzaSyCqJtZP_DMNwjU35ZWSQanTF1xIbr8FvH4'

    youtube = build('youtube', 'v3', developerKey=api_key)
    query=SearchQuery

    request = youtube.search().list(
            q=query,
            part='id,snippet',
            maxResults=10
        )

    response = request.execute()

    videos=[]
    thumbnails=[]
    titles=[]

    for search_result in response.get('items', []):
        if search_result['id']['kind'] == 'youtube#video':
            videos.append('%s (%s)' % (search_result['snippet']['title'], search_result['id']['videoId']))
            thumbnails.append(search_result['snippet']['thumbnails']['high']['url'])

    LINKS=[]

    for i in videos:
        endpos=i.rfind(")")
        startpos=i.rfind("(")
        link="https://www.youtube.com/watch?v="+str(i[startpos+1:endpos])
        LINKS.append(link)
        titles.append([i[0:startpos]])

    return LINKS[0:3],thumbnails[0:3],titles[0:3]


# For Youtube results
@app.route("/youtube", methods=['POST'])
def youtube():
    _dict = request.get_json()
    keyword = _dict["skills"]
    keywords = keyword.split(",")
    print(type(keyword), keyword)

    #edit code
    final=[]
    arr1=[]
    arr2=[]
    arr3=[]
    for i in keywords:
        arr1,arr2,arr3=YoutubeTopResults(i)
        for j in range(len(arr1)):
            check=[arr1[j],arr2[j],arr3[j]]
            print(check[0])
            print(check[2])
            final.append((check))
    return jsonify(final)

# For finding tasks for students
@app.route("/api", methods=['POST']) # decorator
def home(): # route handler function
    data = request.get_json()
    existing = set(data[0])
    to_acquire = set(data[1])

    org_ratings = dict()
    docs = orgs_ref.stream()
    for doc in docs:
        org_ratings[doc.id] = doc.to_dict()['rating']

    tasks = dict()
    ratings = dict()
    docs = tasks_ref.where('remainingCapacity','>',0).stream()
    for doc in docs:
        doc_dict = doc.to_dict()
        tasks[doc.id] = set(doc_dict['skills'])
        ratings[doc.id] = org_ratings[doc_dict['organisationId']]

    sorted_tasks = list(tasks.keys())
    sorted_tasks = sorted(sorted_tasks, key=lambda x: ratings[x], reverse=True)
    sorted_tasks = sorted(sorted_tasks, key=lambda x: len(existing.intersection(tasks[x])), reverse=False)
    sorted_tasks = sorted(sorted_tasks, key=lambda x: len(to_acquire.intersection(tasks[x])), reverse=True)

    return jsonify(sorted_tasks), 200

app.run(debug = True)
