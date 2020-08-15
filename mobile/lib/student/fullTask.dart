import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upskillindo/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchDocs(skills) async {
  print("HEREEE");
  final response = await http.post(
    'http://10.0.2.2:5000/google',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'skills': 'python,flutter'
    }),
  );
  if(response.statusCode == 200){
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["links"];
    print("RESPONSEEE:" + data[0]);
    return data;
  } else {
    throw Exception("Failed to load videos from YouTube");
  }
}

Future<List<dynamic>> fetchVideos(skills) async{
  final response = await http.post(
      'http://10.0.2.2:5000/youtube',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',

    },
    body: jsonEncode(<String, String>{
      'skills': "python,flutter, html"
    }),
  );

  if(response.statusCode == 200){
    print(json.decode(response.body));
//    return Video.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load videos from YouTube");
  }

}

class Video {
  final String title;
  final String url;
  final String thumbnailUrl;

  Video({this.title, this.url, this.thumbnailUrl});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}


class FullTaskDetails extends StatefulWidget {
  final List<String> skills;
  FullTaskDetails({Key key, this.skills}) : super(key:key);
  @override
  _FullTaskDetailsState createState() => _FullTaskDetailsState();
}

class _FullTaskDetailsState extends State<FullTaskDetails> {

  Future<List<dynamic>> futureVideo;
  Future<List<dynamic>> futureDocs;

  @override
  void initState() {
    super.initState();
    futureDocs = fetchDocs(["python"]);
    futureVideo = fetchVideos(["python"]);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios , color: Colors.red,),
                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      Text("Task title",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      SizedBox(height:10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('These are the instructions for the task. This has to be completed by focusing on the given resources.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ) ,),
                      ),
                      SizedBox(height: 5,),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                    DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                              labelColor: Colors.black,
                              tabs: [
                                Tab(text: "Videos"),
                                Tab(text: "Web Pages"),
                              ]),
                        ),
                        Container(
                          //Add this to give height
                          height: MediaQuery.of(context).size.height/2.8,
                          child: TabBarView(children: [
                            Scaffold(
                              body: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Image(image: NetworkImage("https://www.publicdomainpictures.net/pictures/320000/nahled/background-image.png")),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("Video title"),
                                                RaisedButton.icon(
                                                  color: MaterialColor(0XFF98BEE0, accentColor),
                                                  label: Text("Play"),
                                                  icon: Icon(Icons.play_arrow),
                                                  onPressed: (){},
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Scaffold(
                              body:Center(
                                child: FutureBuilder<List<dynamic>>(
                                  future: futureDocs,
                                  builder: (context, snapshot){
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                onTap: (){
                                                  launchURL(snapshot.data[index]);
                                                },
                                                title: Text(snapshot.data[index]),
                                                leading: Icon(Icons.crop_square),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),//to complex to add futurebuilder here for experiences
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: (){},
                        child: Text("Submit Task"),
                        color: MaterialColor(0XFFEE7A7A,primaryColor),
                        textColor: Colors.white,
                        elevation: 2,
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}

Widget _tabSection(BuildContext context) {

  Future<Video> futureVideo;
  Future<String> futureDocs;



  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: TabBar(
            labelColor: Colors.black,
              tabs: [
            Tab(text: "Videos"),
            Tab(text: "Web Pages"),
          ]),
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height/2.8,
          child: TabBarView(children: [
            Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: <Widget>[
                          Image(image: NetworkImage("https://www.publicdomainpictures.net/pictures/320000/nahled/background-image.png")),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Video title"),
                                RaisedButton.icon(
                                  color: MaterialColor(0XFF98BEE0, accentColor),
                                  label: Text("Play"),
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: (){},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Scaffold(
              body:SingleChildScrollView(
                child: Center(
                  child: FutureBuilder<String>(
                    future: futureDocs,
                    builder: (context, snapshot){
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
//                child: Column(
//                  children: <Widget>[
//                    Card(
//                      child: InkWell(
//                        onTap: (){},//TODO: Send to the website URL,
//                        child: ListTile(
//                          title: Text('Link heading'),
//                          subtitle: Text('Description'),
//                        )
//                      )
//                    ),
//                  ],
//                ),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}
