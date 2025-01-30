import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/src/components/calendar_grid.dart';
import 'package:flutter_persian_calendar/src/components/item_box.dart';

class YearsGrid extends StatelessWidget {
  const YearsGrid({
    required this.selectedYear,
    required this.startingYear,
    required this.endingYear,
    required this.itemColor,
    this.textStyle,
    this.onYearChanged,
    super.key,
  });

  final int selectedYear;
  final int startingYear;
  final int endingYear;
  final Color itemColor;
  final TextStyle? textStyle;
  final ValueChanged<int>? onYearChanged;

  @override
  Widget build(BuildContext context) {
    return CalendarGrid<int>(
      items: List.generate(
        endingYear - startingYear,
        (index) => startingYear + index,
      ),
      itemsPerRow: 3,
      itemBuilder: (context, year, index) {
        return GestureDetector(
          onTap: () => onYearChanged != null ? onYearChanged!(year) : null,
          child: ItemBox(
            value: year.toString(),
            color: selectedYear == year ? itemColor : null,
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
}
