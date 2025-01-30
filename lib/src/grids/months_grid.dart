import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/components/calendar_grid.dart';
import 'package:flutter_persian_calendar/src/components/item_box.dart';
import 'package:flutter_persian_calendar/src/utils/constants.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MonthsGrid extends StatelessWidget {
  const MonthsGrid({
    required this.selectedDate,
    required this.startingDate,
    required this.endingDate,
    required this.itemColor,
    this.textStyle,
    this.onMonthChanged,
    super.key,
  });

  final Jalali selectedDate;
  final Jalali startingDate;
  final Jalali endingDate;
  final Color itemColor;
  final TextStyle? textStyle;
  final ValueChanged<int>? onMonthChanged;

  @override
  Widget build(BuildContext context) {
    return CalendarGrid<String>(
      items: List.generate(
        _endMonth - _startMonth + 1,
        (index) => monthNames[index],
      ),
      itemsPerRow: 3,
      itemBuilder: (context, month, index) {
        final fixedIndex = index + 1;
        return GestureDetector(
          onTap: () =>
              onMonthChanged != null ? onMonthChanged!(fixedIndex) : null,
          child: ItemBox(
            value: month,
            color: selectedDate.month == (fixedIndex) ? itemColor : null,
            textStyle: textStyle,
          ),
        );
      },
      shrinkWrap: true,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  int get _startMonth {
    if (selectedDate.year == startingDate.year) {
      return startingDate.month;
    } else {
      return 1;
    }
  }

  int get _endMonth {
    if (selectedDate.year == endingDate.year) {
      return endingDate.month;
    } else {
      return 12;
    }
  }
}
