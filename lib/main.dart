import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/rendering.dart';
import 'interval_brain.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'menuitems.dart';
import 'workoutdetail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
//import 'workoutdetail.dart';


IntervalBrain intervalBrain = new IntervalBrain();

void main() {
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

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
      routes: <String, WidgetBuilder> {
        '/screen1': (BuildContext context) => new MyHomePage(),
        '/screen2' : (BuildContext context) => new WorkoutDetail(),
//        '/screen3' : (BuildContext context) => new Screen3(),
//        '/screen4' : (BuildContext context) => new Screen4()
      },
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

  int _intervalNumber = 0;
//  int _eventBankLength = eventBrain.eventBank.length;
  int _counter = 0;
  int _durationOfInterval = 0;
  Color _progressColor = Colors.red;
  int _progress = 0;
  double _progressValue = 0;
  String _path;
  File files;

  Timer _timer;
  _MyHomePageState(){

    this._durationOfInterval = intervalBrain.intervalBank[_intervalNumber].durationOfInterval;
    this._progressColor = intervalBrain.intervalBank[_intervalNumber].lpibgColor;
    this._counter = lengthOfWorkout();
    }


  void _startTimer() {
   // _counter = lengthOfWorkout();

         print(
        'counter $_counter intervalNumber $_intervalNumber intervalDuration = $_durationOfInterval progress $_progress progressValue $_progressValue');
     beep ('highBeep.mp3');
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        print(
           'counter $_counter intervalNumber $_intervalNumber intervalDuration = $_durationOfInterval progress $_progress progressValue $_progressValue');
        if (_counter > 0) {
          _counter--;

          switch (_durationOfInterval - _progress) {

            case 0: // Reached the end of an interval, reset the progress, event duration & progress bar colour
              {
                _progress = 1;
                _intervalNumber++;
                _progressColor = intervalBrain.intervalBank[_intervalNumber].lpibgColor;
                _durationOfInterval = intervalBrain.intervalBank[_intervalNumber].durationOfInterval;
                _progressValue = _progress / _durationOfInterval;
                beep(intervalBrain.intervalBank[_intervalNumber].action);
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

  void _resetTimer(){
    _timer.cancel();
    Phoenix.rebirth(context);

  }

  void getWorkouts () async {

    // Will let you pick multiple pdf files at once
    List<File> files = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'txt'],
    );
    print(files);
  }


/*    var fileList =  [];
    var workoutList = [];
    int lengthPath = 0;

// Get the system temp directory.
//    var systemTempDir = Directory.systemTemp;
    final workoutDir = await getApplicationDocumentsDirectory();
//    print ('workoutDir $workoutDir');
    // List directory contents, not recursing into sub-directories,
    // but not following symbolic links.
         workoutDir.list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
//         print(entity.path);
//           final fileName = entity.path;
//      print ('fileName $fileName');
             fileList.add(entity.path);
           print ('file list 1 = $fileList');
         });

      String path =   workoutDir.toString();
      print ('path = $path');
      print ('file list 2 = $fileList');

      for(var i = 0; i < fileList.length; i++) {
        // check if the field is a workout
        print ('in loop');
        print('file list = ${fileList[i]}');
        if(fileList[i].endsWith('.txt')) {
          print('file list = ${fileList[i]}');
          // Remove the path and write the file name to the workout list
          workoutList.add(fileList[i].replaceAll(path, ''));
        }
      }

    workoutList.forEach((element) => print(element));


  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice == MenuItems.select) {getWorkouts();

              } else if (choice == MenuItems.add) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WorkoutDetail()),
                    );
              } else if (choice == MenuItems.delete) {print('Delete');
              } else if (choice == MenuItems.edit) {print('Edit');
              };
            },
            itemBuilder: (BuildContext context){
              return MenuItems.choices.map((String choice){
                return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                );
              }).toList();
            },
          )
        ],
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
                  intervalBrain.intervalBank[_intervalNumber].nameOfWorkout,
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
                  intervalBrain.intervalBank[_intervalNumber].nameOfInterval,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           FloatingActionButton(
             heroTag: 'first',
            onPressed:
            _resetTimer,
            tooltip: 'Reset counter',
            child: Text('Reset'),
         ),
           FloatingActionButton(
             heroTag: 'second',
             onPressed:
             _startTimer,
             tooltip: 'Start counter',
             child: Text('Start'),
    ),


           ],
         ),




      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void updateProgress(bool doBeep) {
    _progress++;
    _progressValue = _progress / _durationOfInterval;
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
  for (var i = 0; i < intervalBrain.intervalBank.length; i++) {
    workoutLength += intervalBrain.intervalBank[i].durationOfInterval;
  }
  return workoutLength;
}

void beep(String beep) {
  final player = AudioCache();
  player.play(beep);
}
/*
void menuChoice(String choice){
  if(choice == MenuItems.select) {
    print('Select');
  }
  else if(choice == MenuItems.add) {
    print('Add');
  }
  else if(choice == MenuItems.delete) {
    print('Delete');
  }
  if(choice == MenuItems.edit) {
    print('Edit');
  }
}

 */
