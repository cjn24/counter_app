import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/rendering.dart';
import 'event_brain.dart';

EventBrain eventBrain = new EventBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
      primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Interval Training App'),
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

  int _eventNumber = 0;
//  int _eventBankLength = eventBrain.eventBank.length;
  int _counter = 0;
  int _eventDuration = 0;
  Color _progressColor = Colors.red;
  int _progress = 0;
  double _progressValue = 0;

  Timer _timer;
  _MyHomePageState(){

    //this._counter = eventBrain.eventBank[_eventBankLength - 1].runTime;
    //this._startEventTime = eventBrain.eventBank[_eventNumber].runTime;
    //this._endEventTime = eventBrain.eventBank[_eventNumber + 1].runTime;
    this._eventDuration = eventBrain.eventBank[_eventNumber].eventDuration;
    this._progressColor = eventBrain.eventBank[_eventNumber].lpibgColor;
    this._counter = lengthOfWorkout();
    }


  void _startTimer() {
   // _counter = lengthOfWorkout();

         print(
        'counter $_counter eventNumber $_eventNumber eventDuration = $_eventDuration progress $_progress progressValue $_progressValue');
     beep ('highBeep.mp3');
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        print(
           'counter $_counter eventNumber $_eventNumber eventDuration = $_eventDuration progress $_progress progressValue $_progressValue');
        if (_counter > 0) {
          _counter--;

          switch (_eventDuration - _progress) {

            case 0: // Reached the end of an interval, reset the progress, event duration & progress bar colour
              {
                _progress = 1;
                _eventNumber++;
                _progressColor = eventBrain.eventBank[_eventNumber].lpibgColor;
                _eventDuration = eventBrain.eventBank[_eventNumber].eventDuration;
                _progressValue = _progress / _eventDuration;
                beep(eventBrain.eventBank[_eventNumber].action);
              }
            break;

            case 1: // beep 1 second warning & increment counters
              { updateProgress(true); }
            break;

            case 2: // beep 2 second warning & increment counters
              { updateProgress(true); }
            break;

            case 3: // beep 3 second warning & increment counters
              { updateProgress(true); }
            break;

            default: // > 3 seconds before end of interval, increment counters only
              { updateProgress(false); }
            break;
          }

        } else {
          _timer.cancel();
      }});
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 10,
              child: Container(
               // padding: new EdgeInsets.fromLTRB(32.0,10.0,32.0,10.0),
                width: 325.0,
                height: 40.0,
                child: Text(
                  eventBrain.eventBank[_eventNumber].segmentName,
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                  ),
              ),
            ),
            Container(
                height: 40.0,
                width: 325.0,
                child:
                LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: _progressColor,
                ),
            ),
            SizedBox(
              height: 100.0,
              width: 325.0,

            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              elevation: 10,
              child: Container(
                width: 325.0,
                height: 40.0,
                child: Text(
                  clockString(_counter),
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:
        _startTimer,
        tooltip: 'Start counter',
        child: Text('Start'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void updateProgress(bool doBeep) {
    _progress++;
    _progressValue = _progress / _eventDuration;
    if (doBeep) {
    beep('pipBeep.mp3');
    }
    }
}
  String clockString(int totalSeconds) {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds ~/ 60) % 60;
    int hours = (totalSeconds ~/ 3600);
    String clock = hours.toString().padLeft(2, '0') + ':' +
        minutes.toString().padLeft(2, '0') + ':' +
        seconds.toString().padLeft(2, '0');
    return clock;
  }

LinearProgressIndicator progressBarColor(color) {
  return LinearProgressIndicator(
    backgroundColor: color,
  );
}
// Calculate the total length of the workout
int lengthOfWorkout() {
  int workoutLength = 0;
  for (var i = 0; i < eventBrain.eventBank.length; i++) {
    workoutLength += eventBrain.eventBank[i].eventDuration;
  }
  return workoutLength;
}

void beep(String beep) {
  final player = AudioCache();
  player.play(beep);
}

