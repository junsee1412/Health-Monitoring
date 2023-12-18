import 'package:flutter/material.dart';
import 'package:jellyfish/MyColor.dart';

class WeekChart extends StatefulWidget {
  WeekChart({super.key});

  final Color barBackgroundColor = baseLatte.withOpacity(0.3);
  final Color barColor = baseLatte;
  final Color touchedBarColor = blueLatte;

  @override
  State<StatefulWidget> createState() => _WeekChart();
}

class _WeekChart extends State<WeekChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}