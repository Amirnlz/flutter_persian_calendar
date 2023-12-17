import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'base_widgets/calendar_base_widget.dart';
import 'day/persian_day_calendar.dart';
import 'month/persian_month_calendar.dart';
import 'theme/shamsi_date_picker_theme.dart';
import 'utils/constants.dart';
import 'year/persian_year_calendar.dart';

class PersianCalendar extends StatefulWidget {
  const PersianCalendar({
    super.key,
    required this.selectedDate,
    required this.calendarStartDate,
    required this.calendarEndDate,
    this.calendarHeight = 360,
    this.calendarWidth = 376,
    required this.onDateChanged,
    required this.calendarTheme,
    this.confirmButtonText = 'تایید',
    required this.onConfirmButtonPressed,
  });

  /// The selected date in the calendar.
  final Jalali selectedDate;

  /// The Calendar start from this date
  final Jalali calendarStartDate;

  /// The Calendar ends to this date
  final Jalali calendarEndDate;

  /// The height of the calendar widget.
  final double calendarHeight;

  /// The width of the calendar widget.
  final double calendarWidth;

  /// On every time user change date
  final ValueChanged<Jalali> onDateChanged;

  /// The calendar theme for customize
  final PersianCalendarTheme calendarTheme;

  /// The confirm button text shown in day widget
  final String confirmButtonText;

  /// Called when user pressed on Confirm button
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
    return CalendarBaseWidget(
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
          startYearFrom: widget.calendarStartDate.year,
          endYearAt: widget.calendarEndDate.year,
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
    if (selectedDate.year == widget.calendarStartDate.year) {
      return widget.calendarStartDate.month;
    } else {
      return 1;
    }
  }

  int get endMonthDatePicker {
    if (selectedDate.year == widget.calendarEndDate.year) {
      return widget.calendarEndDate.month;
    } else {
      return 12;
    }
  }

  int get startDayDatePicker {
    if (selectedDate.year == widget.calendarStartDate.year) {
      return widget.calendarStartDate.day;
    } else {
      return 1;
    }
  }

  int get endDayDatePicker {
    if (selectedDate.year == widget.calendarEndDate.year) {
      return widget.calendarEndDate.day;
    } else {
      return selectedDate.monthLength;
    }
  }
}
