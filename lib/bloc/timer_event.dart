import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  /*
  This abstract class contain the actions of app
  like start , pause , restart , reset and tick
  tick for call TimerBloc that tick has occurred and that it needs to update
        state accordingly .
  */
  TimerEvent([List props = const []]) : super(props);
}

// App actions
class Start extends TimerEvent {
  final int duration;

  Start({@required this.duration}) : super([duration]);

  @override
  String toString() {
    return 'Start {duration: $duration}';
  }
}

class PauseEvent extends TimerEvent {
  final int duration;

  PauseEvent({@required this.duration}) : super([duration]);

  @override
  String toString() {
    return 'Pause {duration: $duration}';
  }
}

class Resume extends TimerEvent {

  @override
  String toString() {
    return 'Resume';
  }
}

class Reset extends TimerEvent {

  @override
  String toString() {
    return 'Reset';
  }
}

class TickEvent extends TimerEvent {
  final int duration;

  TickEvent({@required this.duration}) : super([duration]);

  @override
  String toString() {
    return 'Tick {duration: $duration}';
  }
}

