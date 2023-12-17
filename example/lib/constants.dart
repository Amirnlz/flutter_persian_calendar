import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/flutter_persian_calendar.dart';

final calendarDarkTheme = PersianCalendarTheme(
  textStyle: const TextStyle(
    fontSize: 14,
    color: Color(0XFFF2F2F2),
  ),
  headerTextStyle: const TextStyle(
    fontSize: 14,
    color: Color(0xFFA9D7FF),
  ),
);

final calendarLightTheme = PersianCalendarTheme(
  backgroundColor: const Color(0XFFEDF2F4),
  selectedColor: const Color(0XFFEF233C),
  headerBackgroundColor: const Color(0XFF8D99AE),
  textStyle: const TextStyle(
    fontSize: 14,
    color: Colors.black,
  ),
  headerTextStyle: const TextStyle(
    fontSize: 14,
    color: Colors.black,
  ),
);
