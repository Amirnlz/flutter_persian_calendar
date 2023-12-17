import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'base_widgets/date_picker_base.dart';
import 'day/persian_day_calendar.dart';
import 'month/persian_month_calendar.dart';
import 'theme/shamsi_date_picker_theme.dart';
import 'utils/constants.dart';
import 'year/persian_year_calendar.dart';

class PersianCalendar extends StatefulWidget {
  const PersianCalendar({
    Key? key,
    required this.selectedDate,
    required this.datePickerStartDate,
    required this.datePickerEndDate,
    this.calendarHeight = 360,
    this.calendarWidth = 376,
    required this.onDateChanged,
    required this.calendarTheme,
    this.confirmButtonText = 'تایید',
    required this.onConfirmButtonPressed,
  }) : super(key: key);

  final Jalali selectedDate;
  final Jalali datePickerStartDate;
  final Jalali datePickerEndDate;
  final double calendarHeight;
  final double calendarWidth;
  final ValueChanged<Jalali> onDateChanged;
  final PersianCalendarTheme calendarTheme;
  final String confirmButtonText;
  final VoidCallback onConfirmButtonPressed;

  @override
  State<PersianCalendar> createState() => _PersianCalendarState();
}

class _PersianCalendarState extends State<PersianCalendar> {
  DatePickerView activeDatePickerView = DatePickerView.year;
  late Jalali selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return DatePickerBase(
      calendarHeight: widget.calendarHeight,
      calendarWidth: widget.calendarWidth,
      shamsiDatePickerTheme: widget.calendarTheme,
      year: selectedDate.year,
      monthNumber: selectedDate.month,
      onMonthHeaderTapped: () {
        changeView(DatePickerView.month);
      },
      onYearHeaderTapped: () {
        changeView(DatePickerView.year);
      },
      child: _changeDatePickerView(),
    );
  }

  Widget _changeDatePickerView() {
    switch (activeDatePickerView) {
      case DatePickerView.year:
        return PYearCalendar(
          selectedYear: selectedDate.year,
          startYearFrom: widget.datePickerStartDate.year,
          endYearAt: widget.datePickerEndDate.year,
          onYearChanged: (selectedYear) {
            changeView(DatePickerView.month);
            changeSelectedDate(year: selectedYear);
          },
          calendarTheme: widget.calendarTheme,
        );

      case DatePickerView.month:
        return PMonthCalendar(
          selectedMonth: selectedDate.month,
          startMonth: startMonthDatePicker,
          endMonth: endMonthDatePicker,
          onMonthChanged: (selectedMonth) {
            changeView(DatePickerView.day);
            changeSelectedDate(month: selectedMonth);
          },
          calendarTheme: widget.calendarTheme,
        );

      case DatePickerView.day:
        return PDayCalendar(
          selectedDay: selectedDate.day,
          startDay: startDayDatePicker,
          endDay: endDayDatePicker,
          onDayChanged: (selectedDay) {
            changeSelectedDate(day: selectedDay);
          },
          calendarTheme: widget.calendarTheme,
          confirmButtonText: widget.confirmButtonText,
          onConfirmButtonPressed: widget.onConfirmButtonPressed,
        );
    }
  }

  void changeView(DatePickerView view) {
    setState(() {
      activeDatePickerView = view;
    });
  }

  void changeSelectedDate({int? year, int? month, int? day}) {
    // setState(() {
    final newJalaliDate = Jalali(
      year ?? selectedDate.year,
      month ?? selectedDate.month,
      day ?? selectedDate.day,
    );
    widget.onDateChanged(newJalaliDate);
    setState(() {
      selectedDate = newJalaliDate;
    });
    // });
  }

  int get startMonthDatePicker {
    if (selectedDate.year == widget.datePickerStartDate.year) {
      return widget.datePickerStartDate.month;
    } else {
      return 1;
    }
  }

  int get endMonthDatePicker {
    if (selectedDate.year == widget.datePickerEndDate.year) {
      return widget.datePickerEndDate.month;
    } else {
      return 12;
    }
  }

  int get startDayDatePicker {
    if (selectedDate.year == widget.datePickerStartDate.year) {
      return widget.datePickerStartDate.day;
    } else {
      return 1;
    }
  }

  int get endDayDatePicker {
    if (selectedDate.year == widget.datePickerEndDate.year) {
      return widget.datePickerEndDate.day;
    } else {
      return selectedDate.monthLength;
    }
  }
}
