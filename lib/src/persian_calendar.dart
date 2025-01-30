import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/components/calendar_header.dart';
import 'package:flutter_persian_calendar/src/main_calendar_view.dart';
import 'package:flutter_persian_calendar/src/utils/constants.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianCalendar extends StatefulWidget {
  const PersianCalendar({
    this.height = 300.0,
    this.initialDate,
    this.startingDate,
    this.endingDate,
    this.onDateChanged,
    this.backgroundColor,
    this.primaryColor,
    this.secondaryColor,
    this.textStyle,
    this.confirmButton,
    super.key,
  });

  final double height;

  /// Defaults to Jalali.now()
  final Jalali? initialDate;

  /// Defaults  = 1300/1/1
  final Jalali? startingDate;

  /// Defaults  = 1405/1/1
  final Jalali? endingDate;

  /// Callback when final date is confirmed (or selected).
  final ValueChanged<Jalali>? onDateChanged;
  final Color? backgroundColor;
  final Color? primaryColor;
  final Color? secondaryColor;
  final TextStyle? textStyle;

  /// If null, an ElevatedButton is shown by default
  final Widget? confirmButton;

  @override
  State<PersianCalendar> createState() => _PersianCalendarState();
}

class _PersianCalendarState extends State<PersianCalendar> {
  late Jalali _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? Jalali.now();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: widget.height,
        padding: kPadding,
        decoration: BoxDecoration(
          color:
              widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          children: [
            CalendarHeader(
              selectedDate: _selectedDate,
              secondaryColor: widget.secondaryColor ??
                  Theme.of(context).colorScheme.secondaryContainer,
              textStyle: _textStyle(context),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: MainCalendarView(
                selectedDate: _selectedDate,
                startingDate: widget.startingDate,
                endingDate: widget.endingDate,
                primaryColor: widget.primaryColor,
                textStyle: widget.textStyle,
                onDateChanged: (value) {
                  setState(() => _selectedDate = value);
                  widget.onDateChanged?.call(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? _textStyle(BuildContext context) =>
      widget.textStyle ?? Theme.of(context).textTheme.titleSmall;
}
