import 'package:flutter/material.dart';
import 'package:upskillindo/student/selectedTasks.dart';
import 'package:upskillindo/student/studentProfile.dart';

const String page1 = "Tasks";
const String page2 = "Profile";

class StudentHomePage extends StatefulWidget {
  StudentHomePage(
      {Key key,
      this.taskTitle,
      this.taskDescription,
      this.taskCapacity,
      this.taskSkills,
      this.taskRemainingCapacity})
      : super(key: key);
  final String taskTitle;
  final String taskDescription;
  final String taskSkills;
  final int taskCapacity;
  final int taskRemainingCapacity;
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List<Widget> _pages;
  Widget _page1;
  Widget _page2;

  int _currentIndex;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _page1 = TaskListPage(
      taskTitle: widget.taskTitle,
      taskDescription: widget.taskDescription,
      taskSkills: widget.taskSkills,
      taskRemainingCapacity: widget.taskRemainingCapacity,
      taskCapacity: widget.taskCapacity,
    );
    _page2 = StudentProfile();

    _pages = [_page1, _page2];

    _currentIndex = 0;
    _currentPage = _page1;
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _currentPage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => changeTab(index),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.red[400],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text(page1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(page2),
            ),
          ],
        ));
  }
}
