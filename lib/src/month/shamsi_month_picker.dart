import 'package:flutter/material.dart';

import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';
import '../utils/constants.dart';

class ShamsiMonthPicker extends StatelessWidget {
  const ShamsiMonthPicker({
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
      maxPerRow: 3,
      itemsCount: monthCount,
      emptyBoxWidget: SizedBox(
        height: calendarTheme.itemHeight,
        width: calendarTheme.monthItemWidth,
      ),
      textDirection: TextDirection.rtl,
      indexItemWidget: (index) {
        final monthItem = startMonth + index;

        return ItemBox(
          itemTitle: monthNames[monthItem - 1],
          itemNumber: monthItem,
          isItemSelected: monthItem == selectedMonth,
          onItemNumberChanged: onMonthChanged,
          itemHeight: calendarTheme.itemHeight,
          itemWidth: calendarTheme.monthItemWidth,
          selectedColor: calendarTheme.selectedColor,
          textStyle: calendarTheme.textStyle,
        );
      },
    );
  }

  int get monthCount => endMonth - startMonth + 1;
}
