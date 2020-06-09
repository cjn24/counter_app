import 'dart:convert';
import 'package:counterapp/workoutdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'interval.dart';
import 'workoutdata.dart';




// Create a Form widget.
class IntervalDetail extends StatefulWidget {
  final WorkoutData data;
  IntervalDetail({this.data});
  @override
  IntervalDetailState createState() {
    return IntervalDetailState(data);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class IntervalDetailState extends State<IntervalDetail> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<IntervalDetailState>.
  final _formKey = GlobalKey<FormState>();


  String _value = '';
  int _sequenceOfInterval = 1;
  int _currentMinutes = 5;
  int _currentSeconds = 30;
  int _runTime = 0;
  int _durationOfInterval = 0;
  String _groupbgColour = 'Colors.red';
  String _nameOfInterval = '';
  String _groupBeep = 'highBeep.mp3';
  String _beepType = 'highBeep.mp3';
  String _bgColour = 'Colors.red';
  String _recordOfInterval;
  String _nameOfWorkout = '';
  int _lengthOfWorkout;

  List<Intervall> _intervalData = List<Intervall>();
  final WorkoutData data;
  IntervalDetailState(this.data);

  // Initialize default values on screen

  void _initialiseDefaults() {
    print('Inside initialize defaults');
    setState(() {
      _value = '';
      _currentMinutes = 5;
      _currentSeconds = 30;
      _durationOfInterval = 0;
      _groupbgColour = 'Colors.red';
      _nameOfInterval = '';
      _groupBeep = 'highBeep.mp3';
      _beepType = 'highBeep.mp3';
      _bgColour = 'Colors.red';
      _sequenceOfInterval++;
    });
  }


  //   Register the choice for the beep Type
  void _choiceRadioButton1(String newBeep) {
    setState(() {
      _beepType = newBeep;
      _groupBeep = newBeep;
      print('beep Type $_beepType');
    });
    return null;
  }


//   Register the choice of the back ground colour for the progress bar
  void _choiceRadioButton2(String newColour) {
    setState(() {
      _bgColour = newColour;
      _groupbgColour = newColour;
      print('bg Colour $_bgColour');
    });
    return null;
  }

  _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_nameOfWorkout.txt');
      print('${directory.path}/$_nameOfWorkout.txt');
      String text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
  }

  Future _save(data) async {
//    String result = utf8.decode(data);
    String result = jsonEncode(data);
    print(result);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_nameOfWorkout.txt');

    await file.writeAsString(result); // mode: FileMode.append);
    print('saved');
  }

  // Build and save each Interval record to an array
  void _buildIntervalRecord() {
    // Validate returns true if the form is valid, or false
    // otherwise.if (_formKey.currentState.validate()) {};
      // If the form is valid, display a Snackbar.

    print ('length of workout hours in build interval record ${data.nameOfWorkout}');
      _lengthOfWorkout = (data.lengthOfWorkoutHours * 60) + data.lengthOfWorkoutMinutes;
      _durationOfInterval = (_currentMinutes * 60) + _currentSeconds;
      _runTime = _runTime + _durationOfInterval;
      _intervalData.add(Intervall(
          data.nameOfWorkout,
          _lengthOfWorkout,
          data.numberOfIntervals,
          _sequenceOfInterval,
          _runTime,
          _durationOfInterval,
          _nameOfInterval,
          _beepType,
          _bgColour));
      print(_intervalData);
//     interval.printValues();
      _initialiseDefaults();
//    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Build a Form widget using the _formKey created above.
//      Form(
//      key: _formKey,
      appBar: AppBar(
        title: Text('Interval Training App'),
      ),
      body: Center(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

//          Show the name of the workout
              new Text(
                'Workout: $_nameOfWorkout',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),

              new Divider(height: 5.0, color: Colors.black),

//          Show the number of the Interval
              new Text(
                ' Interval ${data.nameOfWorkout}',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),

              new Divider(height: 5.0, color: Colors.black),

//          Get the name of the Interval


           TextFormField(
                decoration: const InputDecoration(labelText: 'Name of Interval'),
                keyboardType: TextInputType.text,

              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                  return null;
              },

                onChanged: (_value) =>
                    setState(() { _nameOfInterval = _value;
                    print ('name of interval $_nameOfInterval');
                    print (data.nameOfWorkout);
                    print (data.lengthOfWorkoutHours);
                    print (data.lengthOfWorkoutMinutes);
                    print (data.numberOfIntervals);
                                        })
            ),

              new Divider(height: 5.0, color: Colors.black),

              new Text('Length of the Interval'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new NumberPicker.integer(
                          initialValue: _currentMinutes,
                          minValue: 0,
                          maxValue: 59,
                          onChanged: (newValue) =>
                              setState(() {
                                _currentMinutes = newValue;
                                print('current minutes $_currentMinutes');
                              })),
                      new Text('Minutes: $_currentMinutes'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new NumberPicker.integer(
                          initialValue: _currentSeconds,
                          minValue: 0,
                          maxValue: 59,
                          onChanged: (newValue) =>
                              setState(() {
                                _currentSeconds = newValue;
                                print('Seconds $_currentSeconds');
                              })),
                      new Text('Seconds: $_currentSeconds'),
                    ],
                  ),
                ],
              ),
              new Divider(height: 5.0, color: Colors.black),

//           Get the beep type from the Radio button

              new Text(
                'Beep Type:',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),

              new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    value: 'highBeep.mp3',
                    groupValue: _groupBeep,
                    onChanged: _choiceRadioButton1,
                  ),
                  new Text(
                    'High Beep',
                    style: new TextStyle(
                        fontSize: 16.0),
                  ),
                  new Radio(
                    value: 'lowBeep.mp3',
                    groupValue: _groupBeep,
                    onChanged: _choiceRadioButton1,

                  ),
                  new Text(
                    'Low Beep',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),

                ],
              ),

//          Get the colour for the progress bar indicator from the Radio button

              new Divider(height: 5.0, color: Colors.black),
              new Text(
                'Colour of Progress Bar',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),

              new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    activeColor: Colors.red,
                    value: 'Colors.red',
                    groupValue: _groupbgColour,
                    onChanged: _choiceRadioButton2,
                  ),
                  new Text(
                    'Red',
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                    ),
                  ),
                  new Radio(
                    activeColor: Colors.orange,
                    value: 'Colors.orange',
                    groupValue: _groupbgColour,
                    onChanged: _choiceRadioButton2,
                  ),
                  new Text(
                    'Orange',
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.orange,
                    ),
                  ),
                  new Radio(
                    activeColor: Colors.green,
                    value: 'Colors.green',
                    groupValue: _groupbgColour,
                    onChanged: _choiceRadioButton2,
                  ),
                  new Text(
                    'Green',
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                  ),
                  new Radio(
                    activeColor: Colors.purple,
                    value: 'Colors.purple',
                    groupValue: _groupbgColour,
                    onChanged: _choiceRadioButton2,
                  ),
                  new Text(
                    'Purple',
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.purple,
                    ),
                  ),

                ],
              ),
              new Divider(height: 5.0, color: Colors.black),
// Insert code before here

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Quit'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        _buildIntervalRecord();
                      },
                      child: Text('Next'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Finished'),
                      onPressed: () {
                        _save(_intervalData);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Read'),
                      onPressed: () {
                        _read();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
 //    );


        ),
      );

  }
}







