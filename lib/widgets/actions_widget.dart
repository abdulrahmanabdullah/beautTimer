import 'package:bloc_timer/bloc/timer_bloc.dart';
import 'package:bloc_timer/bloc/timer_event.dart';
import 'package:bloc_timer/bloc/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionsButton(
          timerBloc: BlocProvider.of<TimerBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionsButton({TimerBloc timerBloc}) {
    final TimerState state = timerBloc.currentState;
    // Start button
    if (state is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.dispatch(Start(duration: state.duration)),
        )
      ];
    }
    // Pause button
    if (state is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () =>
              timerBloc.dispatch(PauseEvent(duration: state.duration)),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.dispatch(Reset()),
        ),
      ];
    }
    // Resume button
    if (state is Paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.dispatch(Resume()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.dispatch(Reset()),
        ),
      ];
    }

    // Reset button
    if (state is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.dispatch(Reset()),
        ),
      ];
    }
  }
}
