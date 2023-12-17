import 'package:flutter/material.dart';

import '../base_widgets/item_box.dart';
import '../base_widgets/items_list_view_widget.dart';
import '../theme/shamsi_date_picker_theme.dart';

class ShamsiYearPicker extends StatefulWidget {
  const ShamsiYearPicker({
    Key? key,
    required this.selectedYear,
    required this.startYearFrom,
    required this.endYearAt,
    required this.onYearChanged,
    required this.calendarTheme,
  }) : super(key: key);
  final int selectedYear;
  final int startYearFrom;
  final int endYearAt;
  final ValueChanged<int> onYearChanged;
  final PersianCalendarTheme calendarTheme;

  @override
  State<ShamsiYearPicker> createState() => _ShamsiYearPickerState();
}

class _ShamsiYearPickerState extends State<ShamsiYearPicker> {
  final int yearMaxPerRow = 3;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollToInitialFocusedDate();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListViewWidget(
      scrollController: _scrollController,
      maxPerRow: yearMaxPerRow,
      textDirection: TextDirection.ltr,
      itemsCount: (widget.endYearAt - widget.startYearFrom) + 1,
      emptyBoxWidget: SizedBox(
        height: widget.calendarTheme.itemHeight,
        width: widget.calendarTheme.yearItemWidth,
      ),
      indexItemWidget: (index) {
        final yearItem = widget.startYearFrom + index;
        return ItemBox(
          itemTitle: yearItem.toString(),
          itemNumber: yearItem,
          isItemSelected: yearItem == widget.selectedYear,
          onItemNumberChanged: widget.onYearChanged,
          selectedColor: widget.calendarTheme.selectedColor,
          itemHeight: widget.calendarTheme.itemHeight,
          itemWidth: widget.calendarTheme.yearItemWidth,
          textStyle: widget.calendarTheme.textStyle,
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
    final differenceYear = widget.selectedYear - widget.startYearFrom;
    final scrollOffset =
        differenceYear * (widget.calendarTheme.itemHeight / 2.2);
    return scrollOffset;
  }
}
