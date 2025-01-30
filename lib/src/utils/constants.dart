import 'package:flutter/material.dart' show EdgeInsets;
import 'package:shamsi_date/shamsi_date.dart';

const kPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 16);

const kRadius = 4.0;

final kStartingDate = Jalali(1300);
final kEndingDate = Jalali(1405);

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
