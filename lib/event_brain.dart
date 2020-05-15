import 'Event.dart';

class EventBrain{
  List<Event> eventBank = [
    Event(0,	'Warmup',	'highBeep', 'cyan'),
    Event(17,	'Warmup',	'highBeep',	'cyan'),
    Event(18,	'Warmup',	'highBeep',	'cyan'),
    Event(19,	'Warmup',	'highBeep',	'cyan'),
    Event(20,	'Interval 1 High', 'highBeep', 'red'),
    Event(27,	'Interval 1 High', 'pipBeep',	'red'),
    Event(28,	'Interval 1 High', 'pipBeep',	'red'),
    Event(29,	'Interval 1 High', 'pipBeep',	'red'),
    Event(30,	'Interval 1 Low', 'lowBeep',	'green'),
    Event(47,	'Interval 1 Low', 'pipBeep',	'green'),
    Event(48,	'Interval 1 Low', 'pipBeep',	'green'),
    Event(49,	'Interval 1 Low', 'pipBeep',	'green'),
    Event(50,	'Cooldown',	'lowBeep', 'orange'),
  ];

}