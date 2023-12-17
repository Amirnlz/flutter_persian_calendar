import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({
    super.key,
    required this.itemTitle,
    required this.itemNumber,
    required this.isItemSelected,
    required this.onItemNumberChanged,
    required this.itemHeight,
    required this.itemWidth,
    required this.selectedColor,
    required this.textStyle,
  });
  final String itemTitle;
  final int itemNumber;
  final bool isItemSelected;
  final ValueChanged<int> onItemNumberChanged;
  final double itemHeight;
  final double itemWidth;
  final Color selectedColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemNumberChanged(itemNumber);
      },
      child: Container(
        height: itemHeight,
        width: itemWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isItemSelected ? selectedColor : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          itemTitle,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
