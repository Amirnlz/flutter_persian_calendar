import 'package:flutter/widgets.dart';

class PersianCalendarTheme {
  /// The background color of calendar base-widget
  final Color backgroundColor;

  /// The background colors of selected year and month at header of widget
  final Color headerBackgroundColor;

  /// The color of when user select date
  final Color selectedColor;

  /// The textStyle unselected year/month/day in widgets
  final TextStyle textStyle;

  /// The textStyle used when user select item, when it's null we use textStyle
  final TextStyle? selectedItemTextStyle;

  /// The textStyle used for button text, when it's null we use textStyle
  final TextStyle? confirmButtonTextStyle;

  /// The textStyle used for header widget text, when it's null we use textStyle
  final TextStyle? headerTextStyle;

  /// Height of year & month & day item
  final double itemHeight;

  /// Width of year item
  final double yearItemWidth;

  /// Width of month item
  final double monthItemWidth;

  /// Width of day item
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
