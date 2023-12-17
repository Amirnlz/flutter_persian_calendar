import 'package:flutter/material.dart';

import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';
import '../utils/constants.dart';

class PMonthCalendar extends StatelessWidget {
  const PMonthCalendar({
    Key? key,
    required this.selectedMonth,
    required this.startMonth,
    required this.endMonth,
    required this.onMonthChanged,
    required this.calendarTheme,
  }) : super(key: key);
  final int selectedMonth;
  final int startMonth;
  final int endMonth;
  final ValueChanged<int> onMonthChanged;
  final PersianCalendarTheme calendarTheme;

  @override
  Widget build(BuildContext context) {
    return ItemsListViewWidget(
      bottomPaddingSize: calendarTheme.monthItemWidth / 2,
      maxPerRow: 3,
      itemsCount: monthCount,
      emptyBoxWidget: SizedBox(
        height: calendarTheme.itemHeight,
        width: calendarTheme.monthItemWidth,
      ),
      textDirection: TextDirection.rtl,
      indexItemWidget: (index) {
        final monthItem = startMonth + index;
        final isSelected = monthItem == selectedMonth;

        return ItemBox(
          itemTitle: monthNames[monthItem - 1],
          itemNumber: monthItem,
          isItemSelected: isSelected,
          onItemNumberChanged: onMonthChanged,
          itemHeight: calendarTheme.itemHeight,
          itemWidth: calendarTheme.monthItemWidth,
          selectedColor: calendarTheme.selectedColor,
          textStyle: textStyle(isSelected),
        );
      },
    );
  }

  int get monthCount => endMonth - startMonth + 1;

  TextStyle textStyle(bool isSelected) =>
      isSelected && calendarTheme.selectedItemTextStyle != null
          ? calendarTheme.selectedItemTextStyle!
          : calendarTheme.textStyle;
}
