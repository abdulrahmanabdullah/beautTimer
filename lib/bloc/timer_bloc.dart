import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_timer/bloc/timer_event.dart';
import 'package:bloc_timer/bloc/timer_state.dart';
import 'package:bloc_timer/model/ticker.dart';
import 'package:meta/meta.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  //todo : exchange _duration to dynamic var .
  final int _duration = 120;

  final Ticker _ticker;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  StreamSubscription<int> _tickerSubscription;

  @override
  TimerState get initialState => Ready(_duration);

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    }
    else if (event is PauseEvent) {
      yield* _mapPauseToState(event);
    }
    else if(event is Resume) {
      yield* _mapResumeToState(event);
    }
    else if(event is Reset){
      yield* _mapResetToState(event);
    }
    else if (event is TickEvent) {
      yield* _mapTickEventToState(event);
    }
  }

  // Start event
  Stream<TimerState> _mapStartToState(Start start) async* {
    // Call Running state
    yield Running(start.duration);
    // first cancel the prevoius state
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.duration).listen(
      (duration) {
        // send event to mapEventState
        dispatch(TickEvent(duration: duration));
      },
    );
  }

  // Pause Event
  Stream<TimerState> _mapPauseToState(PauseEvent pause) async* {
    final state = currentState; // this is a current state define in bloc library
    if (state is Running) {
      _tickerSubscription.pause();
      // Paused state
      yield Paused(state.duration);
    }
  }

  //Resume
  Stream<TimerState> _mapResumeToState(Resume resume) async* {
    final state = currentState ;
    if(state is Paused){
      _tickerSubscription.resume();
      yield Running(state.duration);
    }
  }

  // Tick event
  Stream<TimerState> _mapTickEventToState(TickEvent tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished();
  }

  //Reset
  Stream<TimerState> _mapResetToState(Reset reset) async*{
    // cancel the current state
   _tickerSubscription?.cancel();
    yield Ready(_duration);
  }

  @override
  void dispose() {
    super.dispose();
    // Avoid memory leak
    _tickerSubscription.cancel();
  }
}
