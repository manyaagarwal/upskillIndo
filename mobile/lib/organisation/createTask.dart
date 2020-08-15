import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:upskillindo/models/task.dart';
import 'package:upskillindo/organisation/organisationHome.dart';
import 'package:upskillindo/theme.dart';
import 'package:http/http.dart' as http;


Future<Task> createTask(Task task) async {
  final http.Response response = await http.post(
    '',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Task>{
      'task': task,
    }),
  );

  if (response.statusCode == 201) {
    return Task.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create task.');
  }
}

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  String skillsRequired = "";

  Future<Task> _futureTask;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                    controller:titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Task Title"
                    )
                ),
                SizedBox(height: 5,),
                TextField(
                    controller:descriptionController,
                    minLines: 5,
                    maxLines: 8,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Task Description"
                    )
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: capacityController,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Task enrollment capacity"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                SizedBox(height: 5,),
                FlutterTagging(
                  textFieldDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Tags",
                      labelText: "Skills Required"),
                  addButtonWidget: _buildAddButton(),
                  chipsColor: MaterialColor(0XFF98BEE0, accentColor),
                  chipsFontColor: Colors.white,
                  deleteIcon: Icon(Icons.cancel,color: Colors.white),
                  chipsPadding: EdgeInsets.all(2.0),
                  chipsFontSize: 14.0,
                  chipsSpacing: 5.0,
                  chipsFontFamily: 'helvetica_neue_light',
                  suggestionsCallback: (pattern) async {
                    return await TagSearchService.getSuggestions(pattern);
                  },
                  onChanged: (result) {
                    setState(() {
                      skillsRequired = result.toString();
                    });
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  onPressed: (){
                    Task task = new Task(
                        title: titleController.text,
                        description: descriptionController.text,
                        capacity: int.parse(capacityController.text),
                        skills: skillsRequired);
                    setState(() {
                      _futureTask = createTask(task);
                    });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OrganisationHomePage()),
                  );
                  },
                  color:MaterialColor(0XFFEE7A7A,primaryColor),
                  textColor: Colors.white,
                  icon: Icon(Icons.note_add),
                  label: Text("Add Task"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildAddButton() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color:MaterialColor(0XFF98BEE0, accentColor),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.add,
          color: Colors.white,
          size: 15.0,
        ),
        Text(
          "Add New Tag",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ],
    ),
  );
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 2});
    tagList.add({'name': "Dart", 'value': 3});
    tagList.add({'name': "Web Devlopment", 'value': 4});
    List<dynamic> filteredTagList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredTagList.add({'name': query, 'value': 0});
    }
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}