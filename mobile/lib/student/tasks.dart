import 'package:flutter/material.dart';
import 'package:upskillindo/student/task.dart';
import 'package:http/http.dart' as http;
import 'package:upskillindo/theme.dart';

class TasksList extends StatefulWidget {
  TasksList({Key key, this.existingSkills, this.skillsToAcquire}) : super(key:key);
  final List<String> existingSkills;
  final List<String> skillsToAcquire;
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick Tasks'),
        ),
        body: Container(
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
                            taskCapacity: 3, taskRemainingCapacity: 1,
                            taskDescription: "Description text in detail", taskSkills: "Skills needed for this task", taskTitle: "Task title",)
                      )
                    );
                  },
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Task title'),
                    subtitle: Text(
                        'Company Name \nSkills: Skills List'
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: InkWell(
                  onTap: (){},
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Task title'),
                    subtitle: Text(
                        'Company Name \nSkills: Skills List'
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: InkWell(
                  onTap: (){},
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Task title'),
                    subtitle: Text(
                        'Company Name \nSkills: Skills List'
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: InkWell(
                  onTap: (){},
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Task title'),
                    subtitle: Text(
                        'Company Name \nSkills: Skills List'
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: InkWell(
                  onTap: (){},
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Task title'),
                    subtitle: Text(
                        'Company Name \nSkills: Skills List'
                    ),
                    isThreeLine: true,
                  ),
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
