import 'package:flutter/material.dart';

import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';
import '../utils/constants.dart';
import 'day_confirmation_button.dart';

class PDayCalendar extends StatelessWidget {
  const PDayCalendar({
    super.key,
    required this.selectedDay,
    required this.startDay,
    required this.endDay,
    required this.onDayChanged,
    required this.calendarTheme,
    required this.confirmButtonText,
    required this.onConfirmButtonPressed,
  });
  final int selectedDay;
  final int startDay;
  final int endDay;
  final ValueChanged<int> onDayChanged;
  final PersianCalendarTheme calendarTheme;
  final String confirmButtonText;
  final VoidCallback onConfirmButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            weekShortNames.length,
            (index) => SizedBox(
              width: calendarTheme.dayItemWidth,
              child: Text(
                weekShortNames[index],
                textAlign: TextAlign.center,
                style: weekNameTextStyle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ItemsListViewWidget(
            itemsCount: (endDay - startDay) + 1,
            maxPerRow: 7,
            textDirection: TextDirection.rtl,
            emptyBoxWidget: SizedBox(
              height: calendarTheme.itemHeight,
              width: calendarTheme.dayItemWidth,
            ),
            indexItemWidget: (index) {
              final dayItem = startDay + index;
              final isSelected = dayItem == selectedDay;
              return ItemBox(
                itemTitle: dayItem.toString(),
                itemNumber: dayItem,
                isItemSelected: isSelected,
                onItemNumberChanged: onDayChanged,
                itemHeight: calendarTheme.itemHeight,
                itemWidth: calendarTheme.dayItemWidth,
                selectedColor: calendarTheme.selectedColor,
                textStyle: textStyle(isSelected),
              );
            },
          ),
        ),
        DayConfirmationButton(
          buttonColor: calendarTheme.selectedColor,
          buttonTextStyle:
              calendarTheme.confirmButtonTextStyle ?? calendarTheme.textStyle,
          onConfirmButtonPressed: onConfirmButtonPressed,
          confirmButtonText: confirmButtonText,
        ),
      ],
    );
  }

  TextStyle get weekNameTextStyle {
    return calendarTheme.textStyle.copyWith(
      color: Colors.white70,
    );
  }

  TextStyle textStyle(bool isSelected) =>
      isSelected && calendarTheme.selectedItemTextStyle != null
          ? calendarTheme.selectedItemTextStyle!
          : calendarTheme.textStyle;
}
