import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class TimerState extends Equatable{
  /*
   This class contain all app states
   like timer is ready  ,timer is  paused or running and finished
   All states should be write here .
   */

  final int duration ;

  TimerState(this.duration, [List props = const []]) : super([duration]..addAll(props));

}


//Read Class
class Ready extends TimerState{

  Ready(int duration) : super(duration);

  @override
  String toString() {
    return 'Ready{ duration : $duration}';
  }

}


class Paused extends TimerState{
  Paused(int duration) : super(duration);

  @override
  String toString() {
    return 'Paused{duration : $duration}';
  }
}

class Running extends TimerState{
  Running(int duration) : super(duration);

  @override
  String toString() {
    return 'Running{duration: $duration}';
  }
}

class Finished extends TimerState{
  Finished() : super(0);

  @override
  String toString() {
    return 'Finished';
  }
}


