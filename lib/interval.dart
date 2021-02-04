import 'dart:ui';
import 'interval.dart';
import 'package:flutter/material.dart';

class Intervall {
  String nameOfWorkout;
  int lengthOfWorkout;
  int numberOfIntervals;
  int sequenceOfInterval;
  int runTime;
  int durationOfInterval;
  String nameOfInterval;
  String action;
  String lpibgColor;

  Intervall(this.nameOfWorkout, this.lengthOfWorkout, this.numberOfIntervals,
      this.sequenceOfInterval, this.runTime, this.durationOfInterval,
      this.nameOfInterval, this.action, this.lpibgColor);

  @override
  String toString() {
    return '{ ${this.nameOfWorkout}, ${this.lengthOfWorkout}, ${this
        .numberOfIntervals}, ${this.sequenceOfInterval}, ${this.runTime}, ${this
        .durationOfInterval}, ${this.nameOfInterval}, ${this.action}, ${this
        .lpibgColor} }';
  }

  // JSON mapping
  Map toJson() =>
      {
        'nameOfWorkout': nameOfWorkout,
        'lengthOfWorkout': lengthOfWorkout,
        'numberOfIntervals': numberOfIntervals,
        'sequenceOfInterval': sequenceOfInterval,
        'runTime': runTime,
        'durationOfInterval': durationOfInterval,
        'nameOfInterval': nameOfInterval,
        'action': action,
        'lpibgColor': lpibgColor
      };

  // Used to decode from JSON
  factory Intervall.fromJson(dynamic json) {
    return Intervall(
        json['nameOfWorkout'] as String,
        json['lengthOfWorkout'] as int,
        json['numberOfIntervals'] as int,
        json['sequenceOfInterval'] as int,
        json['runTime'] as int,
        json['durationOfInterval'] as int,
        json['nameOfInterval'] as String,
        json['action'] as String,
        json['lpibgColor'] as dynamic);
  }


  static Color stringToColor(String str) {
    var color;
    switch (str) {
      case 'Colors.red':
        {
          color = Colors.red;
          return color;
        }
        break;
      case 'Colors.cyan':
        {
          color = Colors.cyan;
          return color;
        }
        break;
      case 'Colors.green':
        {
          color = Colors.green;
          return color;
        }
        break;
      case 'Colors.purple':
        {
          color = Colors.purple;
          return color;
        }
        break;
      case 'Colors.orange':
        {
          color = Colors.orange;
          return color;
        }
        break;
      default:
        {
          color = Colors.white;
          return color;
        }
        break;

    }
  }
}