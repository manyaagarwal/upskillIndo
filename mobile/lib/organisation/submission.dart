import 'package:flutter/material.dart';
import 'package:upskillindo/theme.dart';

class Submission extends StatefulWidget {
  @override
  _SubmissionState createState() => _SubmissionState();
}

class _SubmissionState extends State<Submission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jessica's submission"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Deliverables',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 2,
            ),
            //TODO: Add grid
          ],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {},
        color: MaterialColor(0XFF98BEE0, accentColor),
        child: Text("Give Feedback"),
      ),
    );
  }
}
