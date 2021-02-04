import 'package:counterapp/main.dart';
import 'main.dart';
import 'menuitems.dart';
import 'interval.dart';


class WorkoutData {

  String nameOfWorkout;
  int lengthOfWorkoutHours = 0;
  int lengthOfWorkoutMinutes = 45;
  int numberOfIntervals = 12;
  int sequenceOfInterval;
  int runTime;
  int durationOfInterval;
  int currentMinutes;
  int currentSeconds;
  String nameOfInterval;
  String action;
  String lpibgColor;
  String choice;
  int i = 0;


  Future  printWorkoutData() async {
    print ('printWorkoutData started');

    print ('printWorkoutData finished');
    print ('intervalBrain.intervalBank');
    print ('i name        dur int');
    print('$nameOfWorkout $lengthOfWorkoutHours $lengthOfWorkoutMinutes $numberOfIntervals $nameOfInterval $currentMinutes $currentSeconds $action $lpibgColor');
    print ('printWorkoutData finished');
 //    print(choice);
  }

  Future initialiseFirstRecord(choice) async {
  print ('initialiseFirstRecord started');
    switch (choice) {
      case MenuItems.add:
        {
          print ('Entered intialise ready for add');
          nameOfWorkout = '';
          lengthOfWorkoutHours = 0;
          lengthOfWorkoutMinutes = 45;
          numberOfIntervals = 12;
          sequenceOfInterval = 0;
          runTime = 0;
          durationOfInterval = 0;
          currentMinutes = 3;
          currentSeconds = 30;
          nameOfInterval = '';
          action = '';
          lpibgColor = '';
//          choice = 'add';
         }
        break;

      case MenuItems.edit:
        {
          print ('Entered intialise ready for edit');
          nameOfWorkout = intervalBrain.intervalBank[0].nameOfWorkout;
          lengthOfWorkoutHours = intervalBrain.intervalBank[0].lengthOfWorkout ~/ 3600;
          lengthOfWorkoutMinutes = (intervalBrain.intervalBank[0].lengthOfWorkout ~/ 60) % 60;
          numberOfIntervals = intervalBrain.intervalBank[0].numberOfIntervals;
          sequenceOfInterval = intervalBrain.intervalBank[0].sequenceOfInterval;
          runTime = intervalBrain.intervalBank[0].runTime;
          durationOfInterval = intervalBrain.intervalBank[0].durationOfInterval;
          print ('intervalBrain.intervalBank[0].durationOfInterval = ${intervalBrain.intervalBank[0].durationOfInterval}');
          currentMinutes = (intervalBrain.intervalBank[0].durationOfInterval ~/ 60) % 60;
          print ('currentMinutes = $currentMinutes');
          currentSeconds = intervalBrain.intervalBank[0].durationOfInterval % 60;
          nameOfInterval = intervalBrain.intervalBank[0].nameOfInterval;
          action = intervalBrain.intervalBank[0].action;
          lpibgColor = intervalBrain.intervalBank[0].lpibgColor;
//          choice = 'edit';

        }
        break;
    }
  print ('initialiseFirstRecord finished');
  }
}
