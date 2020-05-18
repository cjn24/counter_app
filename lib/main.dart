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
      home: MyHomePage(title: 'High Interval Intensity Training App'),
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

  int _runSeconds = 0;
  int _eventNumber = 0;
  int _eventBankLength = eventBrain.eventBank.length;
  int _counter = 0;
  int _startEventTime = 0;
  int _endEventTime = 0;
  int _eventDuration = 0;
  Color _progressColor = Colors.red;
  double _progress = 0;
  double _progressValue = 0;
  bool _newSegment;


//  print(_counter);
//  final dur = duration(seconds: _counter),
  Timer _timer;
  _MyHomePageState(){

    this._counter = eventBrain.eventBank[_eventBankLength - 2].runTime;
    this._startEventTime = eventBrain.eventBank[_eventNumber].runTime;
    this._endEventTime = eventBrain.eventBank[_eventNumber + 1].runTime;
    this._eventDuration = _endEventTime - _startEventTime;
    this._progressColor = eventBrain.eventBank[_eventNumber].lpibgColor;
    this._newSegment = eventBrain.eventBank[_eventNumber].newSegment;


  }



  void beep(String beep) {
    final player = AudioCache();
    player.play(beep);
  }

  void _startTimer() {
     beep ('highBeep.mp3');
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          _runSeconds++;
         // print('runSeconds = $_runSeconds endEventTime = $_endEventTime');
         // print(_endEventTime);
        print ('runSeconds $_runSeconds eventNumber $_eventNumber eventDuration = $_eventDuration progress $_progress');
          if (_progress == _eventDuration -3) {beep('pipBeep.mp3');}
          if (_progress == _eventDuration -2) {beep('pipBeep.mp3');}
          if (_progress == _eventDuration -1) {beep('pipBeep.mp3');}
          if (_runSeconds == _endEventTime) {
              _progress = 0;
              _eventNumber++;
              _startEventTime = eventBrain.eventBank[_eventNumber].runTime;
              _endEventTime = eventBrain.eventBank[_eventNumber + 1].runTime;
              _progressColor = eventBrain.eventBank[_eventNumber].lpibgColor;
              _eventDuration = _endEventTime - _startEventTime;
              beep (eventBrain.eventBank[_eventNumber].action);
            }
            _progressValue = _progress/_eventDuration;
            _progress++;
         // print ('progressValue = $_progressValue eventNumber = $_eventDuration');
         //print (_eventNumber);

        } else {
          _timer.cancel();
        }
      });
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