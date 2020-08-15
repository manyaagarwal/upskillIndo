import 'package:flutter/material.dart';

class OrganisationTasks extends StatefulWidget {
  @override
  _OrganisationTasksState createState() => _OrganisationTasksState();
}

class _OrganisationTasksState extends State<OrganisationTasks> with SingleTickerProviderStateMixin{
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
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          FullTaskDetails()
//                      )
//                  );
                },
                child: ListTile(
                  title: Text('Task title'),
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