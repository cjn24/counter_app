import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
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
      home: MyHomePage(title: 'Counter App'),
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
  String _colour = '';
  double _progress = 0;
  double _progressValue = 0;
//  print(_counter);
//  final dur = duration(seconds: _counter),
  Timer _timer;
  _MyHomePageState(){

    this._counter = eventBrain.eventBank[_eventBankLength - 2].runTime;
    this._startEventTime = eventBrain.eventBank[_eventNumber].runTime;
    this._endEventTime = eventBrain.eventBank[_eventNumber + 1].runTime;
    this._eventDuration = _endEventTime - _startEventTime;
    this._colour = eventBrain.eventBank[_eventNumber].lpibgColor;
    //print('endEventTime = $_endEventTime');
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
          if (_runSeconds == _endEventTime) {
            _progress = 0;
            _eventNumber++;
            _startEventTime = eventBrain.eventBank[_eventNumber].runTime;
            _endEventTime = eventBrain.eventBank[_eventNumber + 1].runTime;
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
              borderRadius: BorderRadius.circular(15.0)
              ),
              elevation: 10,
              child: Text(
                eventBrain.eventBank[_eventNumber].segmentName,
                   style: Theme.of(context).textTheme.display1,
                ),
            ),
            SizedBox(
                height: 40.0,
                width: 300.0,
                child:
                LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.blue,
                semanticsLabel: 'Warmup',
            ),
            ),
 
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              ),
              elevation: 10,
              child: Text(
                clockString(_counter),
                style: Theme.of(context).textTheme.display1,
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

