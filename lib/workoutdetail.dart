import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'intervaldetail.dart';
import 'workoutdata.dart';


class WorkoutDetail extends StatefulWidget {
//  WorkoutDetail({Key key, this.title}) : super(key: key);

  final String title;
  final String choice;
  final WorkoutData data;

  WorkoutDetail({this.title, this.choice, this.data});

//  final String choice;


  @override
  _WorkoutDetailState createState() => new _WorkoutDetailState(choice, data);


}

class _WorkoutDetailState extends State<WorkoutDetail> {



  final WorkoutData data;
  String choice;

  String name = 'test';
  _WorkoutDetailState(this.choice, this.data);

   final myController = TextEditingController();


  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {

    print("Second text field: ${myController.text}");
  }






  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
//                width: 200.0,
                child:  Text(
                    'Add / Edit Workout'
                ),
              ),
              Container(
                // width: 200.0,
                child: TextFormField(
                     initialValue: data.nameOfWorkout,
                     onChanged: (newValue) =>
                      setState(() {
                      data.nameOfWorkout = newValue;
                      data.choice = choice;
                      print ('Name ${data.nameOfWorkout}');
                      print ('choice in workout detail = $choice');
                      data.nameOfInterval = '';
                      data.currentMinutes = 5;
                      data.currentMinutes = 5;
                      data.currentSeconds = 30;
                      data.durationOfInterval = 0;
                      data.lpibgColor = 'Colors.red';
                      data.action = 'highBeep.mp3';
                      data.printWorkoutData();
                      }),
/*
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name of the Workout'
                  ),
*/
                ),
              ),
              new Text('Length of the Workout'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new NumberPicker.integer(
                          initialValue: data.lengthOfWorkoutHours,
                          minValue: 0,
                          maxValue: 12,
                          onChanged: (newValue) =>
                              setState(() { data.lengthOfWorkoutHours = newValue;
                              print ( 'Hours ${data.lengthOfWorkoutHours}');
                              })),
                      new Text('Hours: ${data.lengthOfWorkoutHours}'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new NumberPicker.integer(
                          initialValue: data.lengthOfWorkoutMinutes,
                          minValue: 0,
                          maxValue: 59,
                          onChanged: (newValue) =>
                              setState(() { data.lengthOfWorkoutMinutes = newValue;
                              print ('Minutes ${data.lengthOfWorkoutMinutes}');
                              })),
                      new Text('Minutes: ${data.lengthOfWorkoutMinutes}'),
                    ],
                  ),
                ],
              ),


              Container(
                //   height: 20.0,
                //   width: 150.0,
                child: Center(
                  child: Text(
                    'Number of Intervals',
                  ),
                ),
              ),

              Container(
                //      height: 100.0,
                width: 150.0,
                child: new NumberPicker.integer(
                    initialValue: data.numberOfIntervals,
                    minValue: 1,
                    maxValue: 20,
                    onChanged: (newValue) =>
                        setState(() {data.numberOfIntervals = newValue;
                        print ('Number of Intervals ${data.numberOfIntervals}');
                        data.printWorkoutData();
                        })),
              ),
              Container(
                  child:
                  new Text('Number of Intervals: ${data.numberOfIntervals}')
              ),
              new Divider(height: 5.0, color: Colors.black),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        print('Quit button pressed');
                      },
                      child: Text('Quit'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => IntervalDetail(
                                data: data,
                                choice: choice
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),

              //   ],
              //     ),
            ],
          ),
        ),
      ),
      appBar: new AppBar(
        title: new Text('Interval Training App'),
      ),
    );
  }

}