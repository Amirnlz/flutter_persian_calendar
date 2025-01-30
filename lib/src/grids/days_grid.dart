import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/components/calendar_grid.dart';
import 'package:flutter_persian_calendar/src/components/item_box.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DaysGrid extends StatelessWidget {
  const DaysGrid({
    required this.selectedDate,
    required this.startingDate,
    required this.endingDate,
    required this.itemColor,
    this.textStyle,
    this.onDayChanged,
    super.key,
  });

  final Jalali selectedDate;
  final Jalali startingDate;
  final Jalali endingDate;
  final Color itemColor;
  final TextStyle? textStyle;
  final ValueChanged<int>? onDayChanged;

  @override
  Widget build(BuildContext context) {
    return CalendarGrid<int>(
      items: List.generate(
        _endDay - _startDay + 1,
        (index) => index,
      ),
      itemsPerRow: 7,
      itemBuilder: (context, dayIndex, index) {
        return GestureDetector(
          onTap: () =>
              onDayChanged != null ? onDayChanged!(dayIndex + 1) : null,
          child: ItemBox(
            value: (dayIndex + 1).toString(),
            color: selectedDate.month == (dayIndex + 1) ? itemColor : null,
            textStyle: textStyle,
          ),
        );
      },
      shrinkWrap: true,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.5,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  int get _startDay {
    if (selectedDate.year == startingDate.year) {
      return startingDate.day;
    } else {
      return 1;
    }
  }

  int get _endDay {
    if (selectedDate.year == endingDate.year) {
      return endingDate.day;
    } else {
      return selectedDate.monthLength;
    }
  }
}
