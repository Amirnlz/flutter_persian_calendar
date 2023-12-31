import 'package:flutter/material.dart';

import '../header/selected_value_box.dart';
import '../theme/shamsi_date_picker_theme.dart';

class CalendarHeaderWidget extends StatelessWidget {
  const CalendarHeaderWidget({
    super.key,
    required this.year,
    required this.monthNumber,
    required this.onMonthHeaderTapped,
    required this.onYearHeaderTapped,
    required this.calendarTheme,
  });

  final int year;
  final int monthNumber;
  final VoidCallback onMonthHeaderTapped;
  final VoidCallback onYearHeaderTapped;
  final PersianCalendarTheme calendarTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: MonthNameLabel(
            monthNumber: monthNumber,
            onTap: onMonthHeaderTapped,
            textStyle: headerTextStyle,
            boxColor: calendarTheme.headerBackgroundColor,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: YearLabel(
            yearNumber: year.toString(),
            onTap: onYearHeaderTapped,
            textStyle: headerTextStyle,
            boxColor: calendarTheme.headerBackgroundColor,
          ),
        ),
      ],
    );
  }

  TextStyle get headerTextStyle =>
      calendarTheme.headerTextStyle ?? calendarTheme.textStyle;
}
