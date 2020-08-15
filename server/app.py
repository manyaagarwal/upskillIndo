from flask import Flask, request, jsonify
from firebase_admin import credentials, firestore, initialize_app

app = Flask(__name__)

# Initialize Firestore DB
cred = credentials.Certificate('key.json')
default_app = initialize_app(cred)
db = firestore.client()
tasks_ref = db.collection('tasks')

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
    all_tasks = [doc.to_dict() for doc in tasks_ref.stream()]
    return jsonify(all_tasks), 200

app.run(debug = True)
