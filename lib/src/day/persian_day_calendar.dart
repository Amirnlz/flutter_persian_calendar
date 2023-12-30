import 'package:flutter/material.dart';

import '../base_widgets/calendar_widget.dart';
import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';
import '../utils/constants.dart';
import 'day_confirmation_button.dart';

class PDayCalendar extends StatelessWidget {
  const PDayCalendar({
    super.key,
    required this.onDayChanged,
    required this.calendarTheme,
    required this.confirmButtonText,
    required this.onConfirmButtonPressed,
  });

  final ValueChanged<int> onDayChanged;
  final PersianCalendarTheme calendarTheme;
  final String confirmButtonText;
  final VoidCallback onConfirmButtonPressed;

  @override
  Widget build(BuildContext context) {
    final calendar = context.calendar!;

    final startDay = startDayDatePicker(calendar);
    final endDay = endDayDatePicker(calendar);
    final selectedDay = calendar.selectedDate.day;

    return Column(
      children: [
        _buildWeekDayNames(),
        const SizedBox(height: 12),
        _buildCalendarItems(startDay, endDay, selectedDay),
        _buildDayConfirmationButton(),
      ],
    );
  }

  Widget _buildWeekDayNames() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        weekShortNames.length,
        (index) => SizedBox(
          width: calendarTheme.dayItemWidth,
          child: Text(
            weekShortNames[index],
            textAlign: TextAlign.center,
            style: _weekNameTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarItems(int startDay, int endDay, int selectedDay) {
    return Expanded(
      child: ItemsListViewWidget(
        itemsCount: (endDay - startDay) + 1,
        maxPerRow: 7,
        emptyBoxWidget: SizedBox(
          height: calendarTheme.itemHeight,
          width: calendarTheme.dayItemWidth,
        ),
        indexItemWidget: (index) {
          final dayItem = startDay + index;
          final isSelected = dayItem == selectedDay;
          return _buildItemBox(dayItem, isSelected);
        },
      ),
    );
  }

  Widget _buildItemBox(int dayItem, bool isSelected) {
    return ItemBox(
      itemTitle: dayItem.toString(),
      itemNumber: dayItem,
      isItemSelected: isSelected,
      onItemNumberChanged: onDayChanged,
      itemHeight: calendarTheme.itemHeight,
      itemWidth: calendarTheme.dayItemWidth,
      selectedColor: calendarTheme.selectedColor,
      textStyle: _textStyle(isSelected),
    );
  }

  Widget _buildDayConfirmationButton() {
    return DayConfirmationButton(
      buttonColor: calendarTheme.selectedColor,
      buttonTextStyle:
          calendarTheme.confirmButtonTextStyle ?? calendarTheme.textStyle,
      onConfirmButtonPressed: onConfirmButtonPressed,
      confirmButtonText: confirmButtonText,
    );
  }

  TextStyle get _weekNameTextStyle {
    return calendarTheme.textStyle.copyWith(
      color: Colors.white70,
    );
  }

  TextStyle _textStyle(bool isSelected) =>
      isSelected && calendarTheme.selectedItemTextStyle != null
          ? calendarTheme.selectedItemTextStyle!
          : calendarTheme.textStyle;

  int startDayDatePicker(CalendarWidget calendar) {
    if (calendar.selectedDate.year == calendar.calendarStartDate.year) {
      return calendar.calendarStartDate.day;
    } else {
      return 1;
    }
  }

  int endDayDatePicker(CalendarWidget calendar) {
    if (calendar.selectedDate.year == calendar.calendarEndDate.year) {
      return calendar.calendarEndDate.day;
    } else {
      return calendar.selectedDate.monthLength;
    }
  }
}
