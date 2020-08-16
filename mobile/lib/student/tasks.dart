import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upskillindo/student/task.dart';
import 'package:http/http.dart' as http;
import 'package:upskillindo/theme.dart';

Future<List<dynamic>> fetchTasks(skills) async{
  final response = await http.post(
    'http://10.0.2.2:5000/api',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<List<String>> >{
      'skills': skills
    }),
  );
  if(response.statusCode == 200){
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load data");
  }
}

class TasksList extends StatefulWidget {
  TasksList({Key key, this.existingSkills, this.skillsToAcquire}) : super(key:key);
  final List<String> existingSkills;
  final List<String> skillsToAcquire;
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  Future<List<dynamic>> futureTask;
  List<List<String>> skills= [];
  @override
  void initState() {
    super.initState();
    skills.add(widget.existingSkills);
    skills.add(widget.skillsToAcquire);
    futureTask = fetchTasks(skills);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick Tasks'),
        ),
        body: Container(
//          height: MediaQuery.of(context).size.height/1.5,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Selected tasks based on the skills you have and the skills you want to acquire',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width/1.2,
                child: FutureBuilder<List<dynamic>>(
                  future: futureTask,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                            return(
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              TaskPage(
                                                taskCapacity: snapshot.data[index]["capacity"], taskRemainingCapacity: snapshot.data[index]["remainingCapacity"],
                                                taskDescription: snapshot.data[index]["description"], taskSkills: snapshot.data[index]["skills"].join(','), taskTitle: snapshot.data[index]["title"],)
                                          )
                                      );
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.group_work, size:30),
                                      title: Text(snapshot.data[index]["title"]),
                                      subtitle: Text(
                                          'Company Id: ${snapshot.data[index]["organisationId"]} \nSkills: ${snapshot.data[index]["skills"].join(',')}'
                                      ),
                                      isThreeLine: true,
                                    ),
                                  ),
                                )
                            );
                          });
                    } else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                  } return CircularProgressIndicator();
                  }
                ),
              ),
              SizedBox(height: 50,),
              Text('Load More', style: TextStyle(color: Colors.grey),),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
    )
    );
  }
}
