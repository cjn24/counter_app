import 'Event.dart';
import 'package:flutter/material.dart';

class EventBrain{
  List<Event> eventBank = [
    Event(0,	20, 'Warmup',	'highBeep.mp3', Colors.cyan),
   // Event(17,	'Warmup',	'pipBeep.mp3',	Colors.cyan),
   // Event(18,	'Warmup',	'pipBeep.mp3',	Colors.cyan),
   // Event(19,	'Warmup',	'pipBeep.mp3',	Colors.cyan),
    Event(20,	10, 'Interval 1 High','highBeep.mp3', Colors.red),
   // Event(27,	'Interval 1 High','pipBeep.mp3',	Colors.red),
   // Event(28,	'Interval 1 High','pipBeep.mp3',	Colors.red),
   // Event(29,	'Interval 1 High', 'pipBeep.mp3',	Colors.red),
    Event(30,	20, 'Interval 1 Low', 'lowBeep.mp3',	Colors.green),
   // Event(47,	'Interval 1 Low', 'pipBeep.mp3',	Colors.green),
   // Event(48,	'Interval 1 Low', 'pipBeep.mp3',	Colors.green),
   // Event(49,	'Interval 1 Low', 'pipBeep.mp3',	Colors.green),
    Event(50,	10, 'Cooldown',	'lowBeep.mp3', Colors.orange),
    Event(61, 1, 'End', 'lowBeep.mp3', Colors.cyan),
    ];

}