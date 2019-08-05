import 'package:bloc_timer/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/ticker.dart';
import 'bloc/timer_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer BloC",
      theme: ThemeData(
          primaryColor: Color(0xff5BA8EB),
          accentColor: Color.fromRGBO(27, 74, 126, 1),
          brightness: Brightness.dark),
      home: BlocProvider(
        builder: (context) => TimerBloc(ticker: Ticker()),
        child: TimerWidget(),
      ),
    );
  }
}

main() => runApp(MyApp());
