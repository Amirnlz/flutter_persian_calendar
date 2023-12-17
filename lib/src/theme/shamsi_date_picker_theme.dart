import 'package:flutter/widgets.dart';

class PersianCalendarTheme {
  final Color backgroundColor;
  final Color headerBackgroundColor;
  final Color selectedColor;
  final TextStyle textStyle;
  final TextStyle? selectedItemTextStyle;
  final TextStyle? confirmButtonTextStyle;
  final TextStyle? headerTextStyle;
  final double itemHeight;
  final double yearItemWidth;
  final double monthItemWidth;
  final double dayItemWidth;

  PersianCalendarTheme({
    this.backgroundColor = const Color(0xFF262F34),
    this.headerBackgroundColor = const Color(0x1AA9D7FF),
    this.selectedColor = const Color(0xFF3C7DFF),
    required this.textStyle,
    this.selectedItemTextStyle,
    this.confirmButtonTextStyle,
    this.headerTextStyle,
    this.itemHeight = 32,
    this.yearItemWidth = 84,
    this.monthItemWidth = 84,
    this.dayItemWidth = 32,
  });
}
