import 'package:flutter_persian_calendar/src/utils/constants.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension JalaliExtension on Jalali {
  String monthName() {
    return monthNames[month - 1];
  }
}
