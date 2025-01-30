import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/components/calendar_header.dart';
import 'package:flutter_persian_calendar/src/main_calendar_view.dart';
import 'package:flutter_persian_calendar/src/utils/constants.dart';
import 'package:flutter_persian_calendar/src/utils/extensions.dart';
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

  /// set height for the widget
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

  /// Keep track of which grid to show
  CalendarViewMode _viewMode = CalendarViewMode.year;

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
          color: widget.backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          children: [
            CalendarHeader(
              selectedDate: _selectedDate,
              secondaryColor: widget.secondaryColor ??
                  Theme.of(context).colorScheme.secondaryContainer,
              textStyle: _textStyle(context),
              onViewChanged: (value) => setState(() => _viewMode = value),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: MainCalendarView(
                  viewMode: _viewMode,
                  selectedDate: _selectedDate,
                  startingDate: widget.startingDate,
                  endingDate: widget.endingDate,
                  primaryColor: widget.primaryColor,
                  textStyle: widget.textStyle,
                  onViewChanged: (value) => setState(() => _viewMode = value),
                  onDateChanged: (value) {
                    setState(() => _selectedDate = value);
                    widget.onDateChanged?.call(value);
                  },
                ),
              ),
            ),
            Visibility(
              visible: widget.confirmButton != null,
              replacement: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  fixedSize:
                      WidgetStatePropertyAll(Size.fromWidth(double.maxFinite)),
                ),
                child: const Text('تایید'),
              ),
              child: widget.confirmButton ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? _textStyle(BuildContext context) =>
      widget.textStyle ?? Theme.of(context).textTheme.titleSmall;
}
