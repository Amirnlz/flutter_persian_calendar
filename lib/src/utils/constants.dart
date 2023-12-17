import 'package:flutter/material.dart' show EdgeInsets;

const kPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 16);

enum DatePickerView {
  year,
  month,
  day,
}

const monthNames = [
  'فروردین',
  'اردیبهشت',
  'خرداد',
  'تیر',
  'مرداد',
  'شهریور',
  'مهر',
  'آبان',
  'آذر',
  'دی',
  'بهمن',
  'اسفند',
];
