import 'package:flutter/material.dart';
import 'package:upskillindo/organisation/createTask.dart';
import 'package:upskillindo/student/preferences.dart';
import 'package:upskillindo/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0XFFEE7A7A,primaryColor),
        accentColor: MaterialColor(0XFF98BEE0, accentColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'UpSkill Indo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(30),
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => StudentPreferences()),
                  );
                },
                child: Container(
                    height: 150,
                    width: 150,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage('assets/undraw_exams_g4ow.png')),
                        Text('Student'),
                      ],
                    )
                ),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(30),
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTask()),
                  );
                },
                child: Container(
                    height: 150,
                    width: 150,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage('assets/undraw_business_shop_qw5t.png')),
                        Text('Organisation'),
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
