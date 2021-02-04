import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/rendering.dart';
import 'interval_brain.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'menuitems.dart';
import 'workoutdetail.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'getworkouts.dart';
import 'dart:convert';
import 'interval.dart';
import 'workoutdata.dart';





enum ConfirmAction { CANCEL, ACCEPT }
IntervalBrain intervalBrain = new IntervalBrain();
List<Intervall> intervalData = new List<Intervall>();
int sequenceOfInterval = 0;
String choice ='';
int runTime = 0;


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
final WorkoutData data = new WorkoutData();
class _MyHomePageState extends State<MyHomePage> {

  int _intervalNumber = 0;
//  int _eventBankLength = eventBrain.eventBank.length;
  int _counter = 0;
  int _durationOfInterval = 0;
  Color _progressColor = Colors.red;
  int _progress = 0;
  double _progressValue = 0;
  File files;
  String selectedWorkout = 'No selected workout';
//  String choice;
  String _nameOfInterval;
  String _nameOfWorkout;
  bool _isFinished;
  Future<Directory> workoutDir;
  List<String> workoutList = [];

  Timer _timer;
  _MyHomePageState(){
    this._nameOfWorkout = intervalBrain.intervalBank[0].nameOfWorkout;
    this._nameOfInterval = intervalBrain.intervalBank[0].nameOfInterval;
    this._durationOfInterval = intervalBrain.intervalBank[0].durationOfInterval;
    this._progressColor = Intervall.stringToColor(intervalBrain.intervalBank[0].lpibgColor);
    this._counter = intervalBrain.intervalBank[0].lengthOfWorkout;
    this._isFinished = false;

  }




  void _startTimer() {
   // _counter = lengthOfWorkout();
//    print ('${intervalBrain.intervalBank[_intervalNumber].nameOfWorkout} ${intervalBrain.intervalBank[_intervalNumber].lengthOfWorkout} ${intervalBrain.intervalBank[_intervalNumber].nameOfInterval} ${intervalBrain.intervalBank[_intervalNumber].durationOfInterval}');
//         print(
//        'counter $_counter intervalNumber $_intervalNumber intervalDuration = $_durationOfInterval progress $_progress progressValue $_progressValue');
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
                _nameOfWorkout = intervalBrain.intervalBank[_intervalNumber].nameOfWorkout;
                _nameOfInterval = intervalBrain.intervalBank[_intervalNumber].nameOfInterval;
                _progressColor = Intervall.stringToColor(intervalBrain.intervalBank[_intervalNumber].lpibgColor);
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
          _nameOfInterval = 'End';
          _progressValue = 0;
          _progressColor = Colors.white;
      }});
    });
  }

  void _resetTimer(){
    _timer.cancel();
    Phoenix.rebirth(context);

  }

    getWorkoutList(choice) async {
// Get all the workout on file and write them to a pop up menu
//  print ('getWorkoutList started');
    List<FileSystemEntity> fileList = [];
    List<String> workoutList = [];


// Get the system directory.
      Directory   workoutDir = await getApplicationDocumentsDirectory();
//    final workoutDir = new Directory('/data/user/0/com.example.counterapp/app_flutter/');

// List directory contents, not recursive
    fileList = workoutDir.listSync(recursive: false, followLinks: false);

//    for(var i=0;i< fileList.length - 1;i++) {
//      print('$i ${fileList[i].path}');
//    }

    for (var i = 0; i < fileList.length - 1; i++) {
      // check if the field is a workout
//      print('in loop');

      if (fileList[i].path.endsWith('.txt')) {
//          print('file list = ${fileList[i]}');
// Remove the path and write the file name to the workout list
        var completePath = fileList[i].path;
        var fileName = (completePath
            .split('/')
            .last);
        fileName = fileName.substring(0, fileName.length - 4);
        var filePath = completePath.replaceAll("/$fileName", '');
        workoutList.add(fileName);
      }
    }
//    workoutList.forEach((element) => print('workoutList = $element'));


//    Go to screen to display the workouts available
//    navigateAndDisplaySelection(context, choice, workoutList, workoutDir);
//    print ('Selected workout in main is = $selectedWorkout');
//    print ('getWorkoutList ended');
    return workoutList;
  }

  Future navigateAndDisplaySelection(BuildContext context, choice, workoutList) async {
    print ('navigateAndDisplaySelection started');

      this.selectedWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
              GetWorkouts(
                  workoutList: workoutList
           )),
    );
//print ('In async = $selectedWorkout');
//print ('Choice = $choice');

      switch (choice) {
        case (MenuItems.select) :

          {print ('selected workout in switch is = $selectedWorkout');
          await loadSelectedWorkout(selectedWorkout, workoutDir);
          initialiseSelectedWorkout();
          }
          break;

        case (MenuItems.delete) :
          {deleteSelectedWorkout(selectedWorkout, workoutDir);}
          break;
        case (MenuItems.edit) :
          { await loadSelectedWorkout(selectedWorkout, workoutDir);
            print ('Edit $selectedWorkout');
          }
      }

//    print ('navigateAndDisplaySelection ended');
  }
//------------------------------------------------------------------------------
  Future loadSelectedWorkout(selectedWorkout, workoutDir) async{
//    print ('loadSelectedWorkout started');
//    print ('name of selected workout in load  = $selectedWorkout');
//    final file = File('${workoutDir.path}/${selectedWorkout}.txt');
      await _read(selectedWorkout);
//    print ('loadSelectedWorkout finished');
  }

  Future _read(selectedWorkout) async {
//      print ('_read started');
    try {
//      print ('selected workout = $selectedWorkout');
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${selectedWorkout}.txt');
//      final file = File('${directory.path}/${data.nameOfWorkout}.txt');
//      print('file = $file');
      String text =  await file.readAsString();
//      print(text);
      decodeJsonFile(text);
    } catch (e) {
      print("Couldn't read file");
    }
//    print ('_read ended');
  }

  Future decodeJsonFile(text) {
//      print ('decodeJsonFile started');
    var intervallObjsJson = jsonDecode(text) as List;
//    print('interval object json $intervallObjsJson');
    List<Intervall> newIntervalData = intervallObjsJson.map((tagJson) =>
        Intervall.fromJson(tagJson)).toList();
//    print('new intervaldata');
//    print('i name of interval');
//    for (var i = 0; i < newIntervalData.length - 1; i++) {
//      print('$i ${newIntervalData[i].nameOfInterval}');
//    }
    setState(() {
      intervalBrain.intervalBank = newIntervalData.map((element) => element).toList();
      });
//    print ('intervalBrain.intervalBank');
//    print ('i name        dur int');
//    for(var i=0;i< intervalBrain.intervalBank.length - 1;i++) {
//
//      print('$i ${intervalBrain.intervalBank[i].nameOfWorkout} ${intervalBrain.intervalBank[i].lengthOfWorkout} ${intervalBrain.intervalBank[i].nameOfInterval}');
//    }
//    print ('decodeJsonFile ended');
//    intervalBrain.intervalBank = newIntervalData.map((element)=>element).toList();
  }

    Future initialiseSelectedWorkout() async{
    print ('initialiseSelectedWorkout started');
     _nameOfWorkout = intervalBrain.intervalBank[0].nameOfWorkout;
    _nameOfInterval = intervalBrain.intervalBank[0].nameOfInterval;
    _counter = intervalBrain.intervalBank[0].lengthOfWorkout;
    _durationOfInterval = intervalBrain.intervalBank[0].durationOfInterval;
    _progressColor = Intervall.stringToColor(intervalBrain.intervalBank[0].lpibgColor);
//    print ('initialiseSelectedWorkout finished');
  }
  
  
void deleteSelectedWorkout(selectedWorkout, workoutDir){
//  print ('in delete routine $selectedWorkout');
    _asyncConfirmDelete(context, selectedWorkout, workoutDir);
}


Future<ConfirmAction> _asyncConfirmDelete(BuildContext context, selectedWorkout, workoutDir) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(selectedWorkout),
        content: const Text(
            'Are you sure you want to delete this workout.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
              print ('Do not delete file');
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);

              final file = File('${workoutDir.path}/${selectedWorkout}.txt');
              file.delete();
//              print ('delete file $file');
            },
          )
        ],
      );
    },
  );
}

    void getWorkoutListAsync(choice) async {
//    print ('getWorkoutListAysnc started');

    workoutList = await getWorkoutList(choice);
    await navigateAndDisplaySelection(context, choice, workoutList,);
    await data.initialiseFirstRecord(choice);
    await data.printWorkoutData();
//    print ('intervalBrain.intervalBank');
//    print ('i name        dur int');
    for(var i=0;i< intervalBrain.intervalBank.length;i++) {

//      print('$i ${intervalBrain.intervalBank[i].nameOfWorkout} ${intervalBrain.intervalBank[i].lengthOfWorkout} ${intervalBrain.intervalBank[i].nameOfInterval} ${intervalBrain.intervalBank[i].durationOfInterval}');
    }if (choice == MenuItems.edit) {
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                WorkoutDetail(
                    choice: choice,
                    data: data
                )),
      );
    }
//    print ('getWorkoutListAsync  finished');
    }


/////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice) {
//              final selectedChoice = choice;
//---------------------------------------------------------------------------
              switch (choice) {
                case (MenuItems.select) :
                  {
                    getWorkoutListAsync(choice);
                     }
                  print (' In select menu');
                  break;
                case (MenuItems.add) :
                  {
//                    data.initialiseFirstRecord(choice);
//                    data.printWorkoutData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              WorkoutDetail(
                                choice: choice,
                                data: data
                              )),
                    );
                  }
                  break;
                case (MenuItems.delete) :
                  {
                    getWorkoutListAsync(choice);
                  }
                  break;
                case (MenuItems.edit) :
                  {getWorkoutListAsync(choice);
/*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            WorkoutDetail(
                                choice: choice,
                                data: data
                            )),
                  );
*/
                  }

              }
           },
            itemBuilder: (BuildContext context) {
              return MenuItems.choices.map((String choice) {
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
                  _nameOfWorkout,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
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
                  _nameOfInterval,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
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


      ),
      // This trailing comma makes auto-formatting nicer for build methods.


    );
  }
    int _currentIndex = 1;

    _displayDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Workout'),
              content: RadioListTile(
                title: Text("Radio Text"),
                groupValue: _currentIndex,
                value: 1,
                onChanged: (val) {
                  setState(() {
                    _currentIndex = val;
                  });
                },

              ),

              actions: <Widget>[
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
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

void beep(String beep) {
  final player = AudioCache();
  player.play(beep);
}

