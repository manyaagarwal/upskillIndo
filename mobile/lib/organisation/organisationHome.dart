import 'package:flutter/material.dart';
import 'package:upskillindo/organisation/createTask.dart';
import 'package:upskillindo/organisation/organisationProfile.dart';
import 'package:upskillindo/organisation/tasks.dart';

const String page1 = "Tasks";
const String page2 = "Profile";

class OrganisationHomePage extends StatefulWidget {
  @override
  _OrganisationHomePageState createState() => _OrganisationHomePageState();
}

class _OrganisationHomePageState extends State<OrganisationHomePage> {
  List<Widget> _pages;
  Widget _page1;
  Widget _page2;

  int _currentIndex;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _page1 = OrganisationTasks();
    _page2 = OrganisationProfile();

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
        floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTask()),
              );
            },
            icon: Icon(Icons.add),
            label: Text("Add Task")),
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
              icon: Icon(Icons.group),
              title: Text(page2),
            ),
          ],
        )
    );
  }
}
