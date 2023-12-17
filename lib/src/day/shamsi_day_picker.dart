import 'package:flutter/material.dart';

import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';
import 'day_confirmation_button.dart';

class ShamsiDayPicker extends StatelessWidget {
  const ShamsiDayPicker({
    Key? key,
    required this.selectedDay,
    required this.startDay,
    required this.endDay,
    required this.onDayChanged,
    required this.calendarTheme,
    required this.confirmButtonText,
    required this.onConfirmButtonPressed,
  }) : super(key: key);
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
        Expanded(
          child: ItemsListViewWidget(
            itemsCount: (endDay - startDay) + 1,
            maxPerRow: 7,
            textDirection: TextDirection.ltr,
            emptyBoxWidget: SizedBox(
              height: calendarTheme.itemHeight,
              width: calendarTheme.dayItemWidth,
            ),
            indexItemWidget: (index) {
              final dayItem = startDay + index;
              return ItemBox(
                itemTitle: dayItem.toString(),
                itemNumber: dayItem,
                isItemSelected: dayItem == selectedDay,
                onItemNumberChanged: onDayChanged,
                itemHeight: calendarTheme.itemHeight,
                itemWidth: calendarTheme.dayItemWidth,
                selectedColor: calendarTheme.selectedColor,
                textStyle: calendarTheme.textStyle,
              );
            },
          ),
        ),
        DayConfirmationButton(
          buttonColor: calendarTheme.selectedColor,
          buttonTextStyle: calendarTheme.textStyle,
          onConfirmButtonPressed: onConfirmButtonPressed,
          confirmButtonText: confirmButtonText,
        ),
      ],
    );
  }
}
