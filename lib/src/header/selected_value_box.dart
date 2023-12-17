import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SelectedValueBox extends StatelessWidget {
  const SelectedValueBox({
    Key? key,
    this.height,
    this.width,
    required this.text,
    required this.textStyle,
    required this.boxColor,
  }) : super(key: key);
  final double? height;
  final double? width;
  final String text;
  final TextStyle textStyle;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}

class MonthContainer extends StatelessWidget {
  const MonthContainer({
    Key? key,
    required this.monthNumber,
    required this.onTap,
    required this.textStyle,
    required this.boxColor,
  }) : super(key: key);
  final int monthNumber;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SelectedValueBox(
        height: 36,
        text: selectedMonthName,
        textStyle: textStyle,
        boxColor: boxColor,
      ),
    );
  }

  String get selectedMonthName => monthNames[monthNumber - 1];
}

class YearContainer extends StatelessWidget {
  const YearContainer({
    Key? key,
    required this.yearNumber,
    required this.onTap,
    required this.textStyle,
    required this.boxColor,
  }) : super(key: key);
  final String yearNumber;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SelectedValueBox(
        height: 36,
        text: yearNumber,
        textStyle: textStyle,
        boxColor: boxColor,
      ),
    );
  }
}
