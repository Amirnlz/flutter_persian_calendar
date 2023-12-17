import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../theme/shamsi_date_picker_theme.dart';
import 'date_picker_header.dart';

class DatePickerBase extends StatelessWidget {
  const DatePickerBase({
    Key? key,
    required this.height,
    required this.width,
    required this.shamsiDatePickerTheme,
    required this.year,
    required this.monthNumber,
    required this.onMonthHeaderTapped,
    required this.onYearHeaderTapped,
    required this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final PersianCalendarTheme shamsiDatePickerTheme;
  final int year;
  final int monthNumber;
  final VoidCallback onMonthHeaderTapped;
  final VoidCallback onYearHeaderTapped;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height,
        width: width,
        padding: kPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: shamsiDatePickerTheme.backgroundColor,
        ),
        child: Column(
          children: [
            DatePickerHeader(
              year: year,
              monthNumber: monthNumber,
              onMonthHeaderTapped: onMonthHeaderTapped,
              onYearHeaderTapped: onYearHeaderTapped,
              calendarTheme: shamsiDatePickerTheme,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
