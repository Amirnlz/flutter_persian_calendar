import 'package:flutter/material.dart';

class CalendarListWidget extends StatelessWidget {
  const CalendarListWidget({
    super.key,
    required this.columnItemNumber,
    required this.itemsCount,
    required this.itemHeight,
    required this.generator,
    this.padding,
    this.controller,
    this.physics,
  });
  final int columnItemNumber;
  final int itemsCount;
  final double itemHeight;
  final Widget Function(int row, int col) generator;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: calculateRowCount,
      shrinkWrap: true,
      padding: padding,
      physics: physics,
      controller: controller,
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(bottom: itemHeight),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            columnItemNumber,
            (columnIndex) => generator(index, columnIndex),
          ),
        );
      },
    );
  }

  int get calculateRowCount {
    return itemsCount ~/ columnItemNumber;
  }
}
