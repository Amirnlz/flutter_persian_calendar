import 'dart:math';

import 'package:flutter/material.dart';

class ItemsListViewWidget extends StatelessWidget {
  const ItemsListViewWidget({
    super.key,
    this.scrollController,
    this.bottomPaddingSize = 16,
    required this.itemsCount,
    required this.maxPerRow,
    required this.indexItemWidget,
    required this.textDirection,
    this.emptyBoxWidget,
  });

  final ScrollController? scrollController;
  final double bottomPaddingSize;
  final int itemsCount;
  final int maxPerRow;
  final Widget Function(int index) indexItemWidget;
  final TextDirection textDirection;
  final Widget? emptyBoxWidget;

  @override
  Widget build(BuildContext context) {
    final numRows = (itemsCount / maxPerRow).ceil();

    final items = List.generate(itemsCount, (index) => index);

    return Directionality(
      textDirection: textDirection,
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        itemCount: numRows,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: bottomPaddingSize),
        ),
        itemBuilder: (context, rowIndex) {
          final start = rowIndex * maxPerRow;
          final end = min(start + maxPerRow, itemsCount);
          final rowItems = items.sublist(start, end);

          final itemLefts = maxPerRow - rowItems.length;

          return Row(
            textDirection: textDirection,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                  rowItems.length, (index) => indexItemWidget(rowItems[index])),
              if (itemLefts > 0)
                ...List.generate(
                  itemLefts,
                  (index) => emptyBoxWidget ?? const SizedBox(),
                ),
            ],
          );
        },
      ),
    );
  }
}
