from flask import Flask, request, jsonify
from firebase_admin import credentials, firestore, initialize_app

app = Flask(__name__)

# Initialize Firestore DB
cred = credentials.Certificate('key.json')
default_app = initialize_app(cred)
db = firestore.client()
tasks_ref = db.collection('tasks')
orgs_ref = db.collection('organisations')

# For Google results
@app.route("/google", methods=['POST'])
def google():
    keyword = request.get_json()
    print(type(keyword), keyword)
    #edit code
    return jsonify(keyword)

# For Youtube results
@app.route("/youtube", methods=['POST'])
def youtube():
    keyword = request.get_json()
    print(type(keyword), keyword)
    #edit code
    return jsonify(keyword)


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
