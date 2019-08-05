import 'package:flutter/material.dart';
import 'package:bloc_timer/bloc/timer_bloc.dart';
import 'package:bloc_timer/bloc/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'actions_widget.dart';
import 'background.dart';

class TimerWidget extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  double waveSeconds = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text("Timer BloC",style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
          children: <Widget>[
            //todo : find formula to convert minute to seconds then converted to % 😞
        BlocBuilder<TimerBloc, TimerState>(
          // if user click start, start move wave
          condition: (previousState, currentState) {
            // Check duration not = 0
            return previousState.duration > 0 || currentState.duration > 0;
          },
          builder: (context, state) {
            // This will take one minute just one 😞
            waveSeconds = (state.duration % 60  ) / 100 ;
            return Background(waveSeconds);
          },
        ),
        // Minutes and seconds layout
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: Center(
                child: BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    // minute layout
                    final String minutesStr = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    // seconds layout
                    final String secondsStr = ((state.duration % 60))
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    return Text(
                      '$minutesStr:$secondsStr',
                      style: TimerWidget.timerTextStyle,
                    );
                  },
                ),
              ),
            ),
            // Call Action Widget
            BlocBuilder<TimerBloc, TimerState>(
              condition: (previousState, currentState) =>
                  currentState.runtimeType != previousState.runtimeType,
              builder: (context, state) => Actions(),
            ),
          ],
        ),
      ]),
    );
  }


  Stream<double> _waveWithSeconds() {
    return Stream.periodic(
        Duration(
          seconds: 1,
        ),
        (x) => x * 0.01).take(60);
  }
}
