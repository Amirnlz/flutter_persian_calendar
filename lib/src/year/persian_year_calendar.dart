import 'package:flutter/material.dart';

import '../base_widgets/calendar_widget.dart';
import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';

class PYearCalendar extends StatefulWidget {
  const PYearCalendar({
    super.key,
    required this.onYearChanged,
    required this.calendarTheme,
  });
  final ValueChanged<int> onYearChanged;
  final PersianCalendarTheme calendarTheme;

  @override
  State<PYearCalendar> createState() => _PYearCalendarState();
}

class _PYearCalendarState extends State<PYearCalendar> {
  late final int selectedYear;
  late final int startYearFrom;
  late final int endYearAt;

  final int yearMaxPerRow = 3;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendar = context.calendar!;
    selectedYear = calendar.selectedDate.year;
    startYearFrom = calendar.calendarStartDate.year;
    endYearAt = calendar.calendarEndDate.year;

    _scrollToInitialFocusedDate();

    return ItemsListViewWidget(
      scrollController: _scrollController,
      maxPerRow: yearMaxPerRow,
      itemsCount: (endYearAt - startYearFrom) + 1,
      emptyBoxWidget: SizedBox(
        height: widget.calendarTheme.itemHeight,
        width: widget.calendarTheme.yearItemWidth,
      ),
      indexItemWidget: (index) {
        final yearItem = startYearFrom + index;
        final isSelected = yearItem == selectedYear;

        return ItemBox(
          itemTitle: yearItem.toString(),
          itemNumber: yearItem,
          isItemSelected: isSelected,
          onItemNumberChanged: widget.onYearChanged,
          selectedColor: widget.calendarTheme.selectedColor,
          itemHeight: widget.calendarTheme.itemHeight,
          itemWidth: widget.calendarTheme.yearItemWidth,
          textStyle: textStyle(isSelected),
        );
      },
    );
  }

  void _scrollToInitialFocusedDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  double get scrollOffset {
    final differenceYear = selectedYear - startYearFrom;
    final scrollOffset =
        differenceYear * (widget.calendarTheme.itemHeight / 2.2);
    return scrollOffset;
  }

  TextStyle textStyle(bool isSelected) =>
      isSelected && widget.calendarTheme.selectedItemTextStyle != null
          ? widget.calendarTheme.selectedItemTextStyle!
          : widget.calendarTheme.textStyle;
}
