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
    keyword = request.get_json()
    print(type(keyword), keyword)

    #edit code
    all_links=[]
    arr=[]
    for i in keyword:
        arr=GoogleTopResults(i)
        for j in range(len(arr)):
            all_links.append(arr[j])

    return jsonify(all_links)


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
        
    return LINKS[0:3],thumbnails[0:3],titles[0:3]

#Youtube Object
class Youtube:  
    
    # init method or constructor   
    def __init__(self, link, thumbnail, title):  
        self.link = link
        self.thumbnail=thumbnail
        self.title=title  

# For Youtube results
@app.route("/youtube", methods=['POST'])
def youtube():
    keyword = request.get_json()
    print(type(keyword), keyword)

    #edit code
    final=[]
    arr1=[]
    arr2=[]
    arr3=[]
    for i in keywords:
        arr1,arr2,arr3=YoutubeTopResults(i)
        for j in range(len(arr1)):
            check=Youtube(arr1[j],arr2[j],arr3[j])
            print(check.link)
            final.append((check))
    
    return jsonify(final)


# For finding tasks for students
@app.route("/api", methods=['POST']) # decorator
def home(): # route handler function
    all_tasks = [doc.to_dict() for doc in tasks_ref.stream()]
    return jsonify(all_tasks), 200

app.run(debug = True)
