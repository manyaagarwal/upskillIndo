import 'package:flutter/material.dart';
import 'package:upskillindo/student/studentHomeState.dart';
import 'package:upskillindo/theme.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key, this.taskTitle, this.taskDescription, this.taskCapacity, this.taskSkills, this.taskRemainingCapacity}) : super(key:key);
  final String taskTitle;
  final String taskDescription;
  final String taskSkills;
  final int taskCapacity;
  final int taskRemainingCapacity;
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskTitle),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Description\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('${widget.taskDescription}\n', style: TextStyle(fontSize: 18, color: Colors.black)),
            SizedBox(height: 20,),
            Text('Skills Used\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(widget.taskSkills, style: TextStyle(fontSize: 18, color: Colors.black)),
            SizedBox(height: 20,),
            Text('Capacity\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text( "${widget.taskRemainingCapacity} / ${widget.taskCapacity}", style: TextStyle(fontSize: 18, color: Colors.black)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>
                  StudentHomePage()
              )
          );
        },
        icon: Icon(Icons.add),
        label: Text('Pick Task'),
      ),
    );
  }
}
