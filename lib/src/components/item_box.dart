import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({
    required this.value,
    this.padding,
    this.color,
    this.textStyle,
    super.key,
  });

  final String value;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}
