import 'package:flutter/material.dart';
import 'package:upskillindo/models/task.dart';



class AllTaskSubmissions extends StatefulWidget {
  final Task task;
  AllTaskSubmissions({Key key, this.task}) :  super(key:key);
  @override
  _AllTaskSubmissionsState createState() => _AllTaskSubmissionsState();
}

class _AllTaskSubmissionsState extends State<AllTaskSubmissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Column(
        children: <Widget>[
          
        ],
      )
    );
  }
}
