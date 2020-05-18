import 'Event.dart';
import 'package:flutter/material.dart';

class EventBrain{
  List<Event> eventBank = [
    Event(0,	'Warmup',	false, 'highBeep.mp3', Colors.cyan),
   // Event(17,	'Warmup',	false, 'pipBeep.mp3',	Colors.cyan),
   // Event(18,	'Warmup',	false, 'pipBeep.mp3',	Colors.cyan),
   // Event(19,	'Warmup',	false, 'pipBeep.mp3',	Colors.cyan),
    Event(20,	'Interval 1 High',true, 'highBeep.mp3', Colors.red),
   // Event(27,	'Interval 1 High',false, 'pipBeep.mp3',	Colors.red),
   // Event(28,	'Interval 1 High',false, 'pipBeep.mp3',	Colors.red),
   // Event(29,	'Interval 1 High',false,  'pipBeep.mp3',	Colors.red),
    Event(30,	'Interval 1 Low', true, 'lowBeep.mp3',	Colors.green),
   // Event(47,	'Interval 1 Low', false, 'pipBeep.mp3',	Colors.green),
   // Event(48,	'Interval 1 Low', false, 'pipBeep.mp3',	Colors.green),
   // Event(49,	'Interval 1 Low', false, 'pipBeep.mp3',	Colors.green),
    Event(50,	'Cooldown',	true, 'lowBeep.mp3', Colors.orange),
    Event(60, 'End', false, 'lowBeep.mp3', Colors.cyan),
    Event(61, 'End', false, 'lowBeep.mp3', Colors.white),
    ];

}