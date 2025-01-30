import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/grids/days_grid.dart';
import 'package:flutter_persian_calendar/src/grids/months_grid.dart';
import 'package:flutter_persian_calendar/src/grids/years_grid.dart';
import 'package:flutter_persian_calendar/src/utils/constants.dart';
import 'package:flutter_persian_calendar/src/utils/extensions.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MainCalendarView extends StatefulWidget {
  const MainCalendarView({
    required this.viewMode,
    required this.selectedDate,
    this.startingDate,
    this.endingDate,
    this.primaryColor,
    this.textStyle,
    this.onViewChanged,
    this.onDateChanged,
    super.key,
  });

  final CalendarViewMode viewMode;
  final Jalali selectedDate;
  final Jalali? startingDate;
  final Jalali? endingDate;
  final Color? primaryColor;
  final TextStyle? textStyle;
  final ValueChanged<CalendarViewMode>? onViewChanged;
  final ValueChanged<Jalali>? onDateChanged;

  @override
  State<MainCalendarView> createState() => _MainCalendarViewState();
}

class _MainCalendarViewState extends State<MainCalendarView> {
  late Jalali _selectedDate;
  late Jalali _startDate;
  late Jalali _endDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _startDate = widget.startingDate ?? kStartingDate;
    _endDate = widget.endingDate ?? kEndingDate;
  }

  @override
  Widget build(BuildContext context) {
    final itemColor =
        widget.primaryColor ?? Theme.of(context).colorScheme.primaryContainer;
    final textStyle = _textStyle(context);
    return switch (widget.viewMode) {
      CalendarViewMode.year => YearsGrid(
          selectedYear: _selectedDate.year,
          startingYear: _startDate.year,
          endingYear: _endDate.year,
          itemColor: itemColor,
          textStyle: textStyle,
          onYearChanged: _handleYearChanged,
        ),
      CalendarViewMode.month => MonthsGrid(
          selectedDate: _selectedDate,
          startingDate: _startDate,
          endingDate: _endDate,
          itemColor: itemColor,
          textStyle: textStyle,
          onMonthChanged: _handleMonthChanged,
        ),
      CalendarViewMode.day => DaysGrid(
          selectedDate: _selectedDate,
          startingDate: _startDate,
          endingDate: _endDate,
          itemColor: itemColor,
          textStyle: textStyle,
          onDayChanged: _handleDayChanged,
        ),
    };
  }

  TextStyle? _textStyle(BuildContext context) {
    return widget.textStyle ?? Theme.of(context).textTheme.titleSmall;
  }

  /// When the user picks a year, we update the selectedDate
  /// and switch to month selection mode.
  void _handleYearChanged(int year) {
    setState(() {
      // Make sure month and day are in range or just keep the same month/day
      final fixedMonth = _selectedDate.month;
      final fixedDay = _selectedDate.day;
      _selectedDate = Jalali(year, fixedMonth, fixedDay);
      widget.onDateChanged?.call(_selectedDate);
      widget.onViewChanged?.call(CalendarViewMode.month);
    });
  }

  /// When the user picks a month, switch to day selection mode.
  void _handleMonthChanged(int month) {
    setState(() {
      // Keep the same day, or clamp if day > end of that month
      final maxDaysInMonth = Jalali(_selectedDate.year, month).monthLength;
      final newDay = (_selectedDate.day <= maxDaysInMonth)
          ? _selectedDate.day
          : maxDaysInMonth;

      _selectedDate = Jalali(_selectedDate.year, month, newDay);
      widget.onDateChanged?.call(_selectedDate);
      widget.onViewChanged?.call(CalendarViewMode.day);
    });
  }

  /// When the user picks a day, we have a full date.
  void _handleDayChanged(int day) {
    setState(() {
      _selectedDate = Jalali(_selectedDate.year, _selectedDate.month, day);
    });

    widget.onDateChanged?.call(_selectedDate);
  }
}
