import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upskillindo/theme.dart';
import 'package:http/http.dart' as http;

Future<Video> fetchVideos(skills) async{
  final response = await http.post(
      'url',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'skills': skills
    }),
  );

  if(response.statusCode == 200){
    print(json.decode(response.body));
    return Video.fromJson(json.decode(response.body));
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
  Future<Video> futureVideo;

  @override
  void initState() {
    super.initState();
    futureVideo = fetchVideos(widget.skills);
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
                      _tabSection(context), //to complex to add futurebuilder here for experiences
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
                child: Column(
                  children: <Widget>[
                    Card(
                      child: InkWell(
                        onTap: (){},//TODO: Send to the website URL,
                        child: ListTile(
                          title: Text('Link heading'),
                          subtitle: Text('Description'),
                        )
                      )
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}
