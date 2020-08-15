import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:upskillindo/student/tasks.dart';
import 'package:upskillindo/theme.dart';


class StudentPreferences extends StatefulWidget {
  @override
  _StudentPreferencesState createState() => _StudentPreferencesState();
}

class _StudentPreferencesState extends State<StudentPreferences> {
  @override
  int _value = 1;
  String existingSkills = "";
  String skillsToAcquire = "";
  var _categories = ["Category A", "Category B", "Category C"];
  String _selectedCategory = "Category A";
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select category',
                        border: OutlineInputBorder(),
                    ),
                    isEmpty: _selectedCategory == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _categories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20,),
              FlutterTagging(
                textFieldDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tags",
                    labelText: "Existing Skills"),
                addButtonWidget: _buildAddButton(),
                chipsColor: MaterialColor(0XFF98BEE0, accentColor),
                chipsFontColor: Colors.white,
                deleteIcon: Icon(Icons.cancel,color: Colors.white),
                chipsPadding: EdgeInsets.all(2.0),
                chipsFontSize: 14.0,
                chipsSpacing: 5.0,
                chipsFontFamily: 'helvetica_neue_light',
                suggestionsCallback: (pattern) async {
                  return await TagSearchService.getSuggestions(pattern);
                },
                onChanged: (result) {
                  setState(() {
                    existingSkills = result.toString();
                  });
                },
              ),
              SizedBox(height: 20,),
              FlutterTagging(
                textFieldDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tags",
                    labelText: "Skills to Acquire"),
                addButtonWidget: _buildAddButton(),
                chipsColor: MaterialColor(0XFF98BEE0, accentColor),
                chipsFontColor: Colors.white,
                deleteIcon: Icon(Icons.cancel,color: Colors.white),
                chipsPadding: EdgeInsets.all(2.0),
                chipsFontSize: 14.0,
                chipsSpacing: 5.0,
                chipsFontFamily: 'helvetica_neue_light',
                suggestionsCallback: (pattern) async {
                  return await TagSearchService.getSuggestions(pattern);
                },
                onChanged: (result) {
                  setState(() {
                    skillsToAcquire = result.toString();
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TasksList(existingSkills: existingSkills, skillsToAcquire: skillsToAcquire,)),
                  );
                },
                color:MaterialColor(0XFFEE7A7A,primaryColor),
                textColor: Colors.white,
                icon: Icon(Icons.widgets),
                label: Text("Select Tasks"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAddButton() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color:MaterialColor(0XFF98BEE0, accentColor),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.add,
          color: Colors.white,
          size: 15.0,
        ),
        Text(
          "Add New Tag",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ],
    ),
  );
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 2});
    tagList.add({'name': "Dart", 'value': 3});
    tagList.add({'name': "Web Devlopment", 'value': 4});
    List<dynamic> filteredTagList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredTagList.add({'name': query, 'value': 0});
    }
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}