import 'package:flutter/material.dart';
import 'package:upskillindo/student/fullTask.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Tasks')),
          bottom: getTabBar()
        ),
        body: getTabBarPages()
    );
  }
  Widget getTabBar() {
    return TabBar(controller: tabController, tabs: [
      Tab(text: "Ongoing",),
      Tab(text: "Completed"),
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, children: <Widget>[
      Container(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          FullTaskDetails()
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
          ],
        ),
      ),
      Container(
          child: Text('Completed List')
      )
    ]);
  }

}
