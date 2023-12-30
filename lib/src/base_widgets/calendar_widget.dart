import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarWidget extends InheritedWidget {
  const CalendarWidget({
    super.key,
    required super.child,
    required this.selectedDate,
    required this.calendarStartDate,
    required this.calendarEndDate,
  });

  final Jalali selectedDate;
  final Jalali calendarStartDate;
  final Jalali calendarEndDate;

  static CalendarWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalendarWidget>();
  }

  @override
  bool updateShouldNotify(CalendarWidget oldWidget) {
    return selectedDate != oldWidget.selectedDate ||
        calendarStartDate != oldWidget.calendarStartDate ||
        calendarEndDate != oldWidget.calendarEndDate;
  }
}

extension CalendarExtension on BuildContext {
  CalendarWidget? get calendar {
    return dependOnInheritedWidgetOfExactType<CalendarWidget>();
  }
}
