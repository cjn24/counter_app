import 'Event.dart';

class EventBrain{
  List<Event> eventBank = [
    Event(0,	'Warmup',	'highBeep.mp3', 'cyan'),
    Event(17,	'Warmup',	'pipBeep.mp3',	'cyan'),
    Event(18,	'Warmup',	'pipBeep.mp3',	'cyan'),
    Event(19,	'Warmup',	'pipBeep.mp3',	'cyan'),
    Event(20,	'Interval 1 High', 'highBeep.mp3', 'red'),
    Event(27,	'Interval 1 High', 'pipBeep.mp3',	'red'),
    Event(28,	'Interval 1 High', 'pipBeep.mp3',	'red'),
    Event(29,	'Interval 1 High', 'pipBeep.mp3',	'red'),
    Event(30,	'Interval 1 Low', 'lowBeep.mp3',	'green'),
    Event(47,	'Interval 1 Low', 'pipBeep.mp3',	'green'),
    Event(48,	'Interval 1 Low', 'pipBeep.mp3',	'green'),
    Event(49,	'Interval 1 Low', 'pipBeep.mp3',	'green'),
    Event(50,	'Cooldown',	'lowBeep.mp3', 'orange'),
    Event(60, 'End', 'lowBeep.mp3', 'white'),
    Event(61, 'End', 'lowBeep.mp3', 'white'),
    ];

}