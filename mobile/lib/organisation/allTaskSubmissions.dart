import 'package:flutter/material.dart';
import 'package:upskillindo/models/task.dart';
import 'package:upskillindo/organisation/submission.dart';



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
        title: Text(widget.task != null ? widget.task.title : "Task Title"),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Submission()),
              );
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              leading: Icon(Icons.person),
              title: Text('Jessica Lennon'),
              trailing: InkWell(
                onTap: (){},
                child: Icon(Icons.star_border),
              ),
            ),
          ),
        ],
      )
    );
  }
}
