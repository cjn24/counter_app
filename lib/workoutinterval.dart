import 'dart:ui';
class WorkoutInterval {
  String nameOfWorkout;
  int lengthOfWorkout;
  int numberOfIntervals;
  int sequenceOfInterval;
  int runTime;
  int durationOfInterval;
  String nameOfInterval;
  String action;
  Color lpibgColor;

  WorkoutInterval (this.nameOfWorkout, this.lengthOfWorkout, this.numberOfIntervals, this.sequenceOfInterval, this.runTime, this.durationOfInterval, this.nameOfInterval, this.action, this.lpibgColor);

  @override
  String toString() {
    return '{ ${this.nameOfWorkout}, ${this.lengthOfWorkout}, ${this.numberOfIntervals}, ${this.sequenceOfInterval}, ${this.runTime}, ${this.durationOfInterval}, ${this.nameOfInterval}, ${this.action}, ${this.lpibgColor} }';
  }
  // JSON mapping
  Map toJson() => {
    'name of workout': nameOfWorkout,
    'lenght of workout': lengthOfWorkout,
    'number of intervals': numberOfIntervals,
    'sequence of interval': sequenceOfInterval,
    'run time': runTime,
    'duration of interval': durationOfInterval,
    'name of interval': nameOfInterval,
    'action': action,
    'lpibg color': lpibgColor
  };


  // Methods (Functions)
  void printValues(){
    print(nameOfWorkout);
    print(sequenceOfInterval);

  }
// Getters and Setters
}