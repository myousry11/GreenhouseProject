import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  final String value;
  final double percent;
  final List<Color> colors;
  final List<double> temperatureThresholds;

  const PercentIndicator({
    required this.value,
    required this.percent,
    required this.colors,
    required this.temperatureThresholds,
  });

  Color _calculateColor() {
    try {
      double temperature = double.parse(value.split(' ')[0]);
      for (int i = 0; i < temperatureThresholds.length; i++) {
        if (temperature <= temperatureThresholds[i]) {
          return colors[i];
        }
      }
    } catch (e) {
      print('Error parsing temperature: $e');
    }
    return colors.last;
  }

  @override
  Widget build(BuildContext context) {
    Color progressColor = _calculateColor();

    return CircularPercentIndicator(
      radius: 150,
      animation: true,
      animationDuration: 500,
      lineWidth: 40,
      percent: percent,
      progressColor: progressColor,
      backgroundColor: Colors.teal.shade100,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        value,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900
        ),
      ),
    );
  }
}
