import 'package:flutter/material.dart';
import 'dart:io';


class GetWorkouts extends StatefulWidget {
//  GetWorkouts({Key key, this.title}) : super(key: key);

//  final String title;
  final List<String>workoutList;
  String selectedWorkout;
  GetWorkouts({this.workoutList});

  @override
  _GetWorkoutsState createState() => new _GetWorkoutsState(workoutList);
}

class _GetWorkoutsState extends State<GetWorkouts> {
  String _currentSelected = 'Workout1';
  final List <String> workoutList;
  String selectedWorkout;
  _GetWorkoutsState(this.workoutList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Workout"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: workoutList
            .map((text) => RadioListTile(
                  groupValue: _currentSelected,
                  title: Text("$text"),
                  value: text,
                  onChanged: (val) {
                    setState(() {
                      selectedWorkout = val;
                      _currentSelected = val;
//                      print('selected workout in selection screen $selectedWorkout');
                    });
                    Navigator.pop(context, selectedWorkout);
                  },
                ))
            .toList(),
      ),

    );
  }
}
