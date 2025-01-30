import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/components/item_box.dart';
import 'package:flutter_persian_calendar/src/utils/jalali_extension.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    required this.selectedDate,
    this.secondaryColor,
    this.textStyle,
    super.key,
  });

  final Jalali selectedDate;
  final Color? secondaryColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ItemBox(
            value: selectedDate.monthName,
            padding: padding,
            textStyle: textStyle,
            color: secondaryColor,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: ItemBox(
            value: selectedDate.year.toString(),
            padding: padding,
            textStyle: textStyle,
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}
