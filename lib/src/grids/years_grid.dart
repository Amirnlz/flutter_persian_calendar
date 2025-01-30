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
    // We'll generate all possible years from startingYear to endingYear inclusive
    final years = List.generate(
      (endingYear - startingYear + 1),
      (index) => startingYear + index,
    );

    // Find the index of the selected year in that list
    // if selectedYear isn’t in the list for some reason, selectedIndex will be -1
    final selectedIndex = years.indexOf(selectedYear);

    return CalendarGrid<int>(
      items: years,
      itemsPerRow: 3,
      scrollToIndex: (selectedIndex >= 0) ? selectedIndex : null,
      itemBuilder: (context, year, index) {
        return GestureDetector(
          onTap: () => onYearChanged?.call(year),
          child: ItemBox(
            value: year.toString(),
            color: (year == selectedYear) ? itemColor : null,
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
