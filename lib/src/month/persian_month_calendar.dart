import 'package:flutter/material.dart';

import '../base_widgets/calendar_widget.dart';
import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';
import '../utils/constants.dart';

class PMonthCalendar extends StatelessWidget {
  const PMonthCalendar({
    super.key,
    required this.onMonthChanged,
    required this.calendarTheme,
  });
  final ValueChanged<int> onMonthChanged;
  final PersianCalendarTheme calendarTheme;

  @override
  Widget build(BuildContext context) {
    final calendar = context.calendar!;
    final startMonth = _startMonthDatePicker(calendar);
    final endMonth = _endMonthDatePicker(calendar);
    final selectedMonth = calendar.selectedDate.month;

    final monthCount = endMonth - startMonth + 1;

    return ItemsListViewWidget(
      bottomPaddingSize: calendarTheme.monthItemWidth / 2,
      maxPerRow: 3,
      itemsCount: monthCount,
      emptyBoxWidget: _buildEmptyBox(),
      indexItemWidget: (index) {
        final monthItem = startMonth + index;
        final isSelected = monthItem == selectedMonth;
        return _buildItemBox(monthItem, isSelected);
      },
    );
  }

  Widget _buildEmptyBox() {
    return SizedBox(
      height: calendarTheme.itemHeight,
      width: calendarTheme.monthItemWidth,
    );
  }

  Widget _buildItemBox(int monthItem, bool isSelected) {
    return ItemBox(
      itemTitle: monthNames[monthItem - 1],
      itemNumber: monthItem,
      isItemSelected: isSelected,
      onItemNumberChanged: onMonthChanged,
      itemHeight: calendarTheme.itemHeight,
      itemWidth: calendarTheme.monthItemWidth,
      selectedColor: calendarTheme.selectedColor,
      textStyle: _textStyle(isSelected),
    );
  }

  TextStyle _textStyle(bool isSelected) =>
      isSelected && calendarTheme.selectedItemTextStyle != null
          ? calendarTheme.selectedItemTextStyle!
          : calendarTheme.textStyle;

  int _startMonthDatePicker(CalendarWidget calendar) {
    return calendar.selectedDate.year == calendar.calendarStartDate.year
        ? calendar.calendarStartDate.month
        : 1;
  }

  int _endMonthDatePicker(CalendarWidget calendar) {
    return calendar.selectedDate.year == calendar.calendarEndDate.year
        ? calendar.calendarEndDate.month
        : 12;
  }
}
