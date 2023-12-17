import 'package:flutter/material.dart';

class DayConfirmationButton extends StatelessWidget {
  const DayConfirmationButton({
    Key? key,
    required this.buttonColor,
    required this.buttonTextStyle,
    required this.onConfirmButtonPressed,
    required this.confirmButtonText,
  }) : super(key: key);
  final Color buttonColor;
  final TextStyle buttonTextStyle;
  final VoidCallback onConfirmButtonPressed;
  final String confirmButtonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onConfirmButtonPressed,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          confirmButtonText,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
