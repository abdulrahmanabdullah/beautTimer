import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Background extends StatelessWidget {
  final double waveWithSeconds ;

  Background(this.waveWithSeconds);
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(184, 189, 245, 0.7),
          ],
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(172, 182, 219, 0.7),
          ],
          [
           Colors.blue,Color(0xff5BA8EB)
          ],
        ],
        durations: [19440, 10800, 6000],
        heightPercentages: [
          0.01,
          0.02,
          waveWithSeconds // todo : bind this value with duration
        ],
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 25,
      backgroundColor: Color(0xffffffff),
    );
  }
}
