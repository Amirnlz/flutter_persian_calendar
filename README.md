# PersianCalendar

A lightweight yet powerful **Persian (Jalali) date picker** widget for Flutter.  
Easily allow your users to select years, months, and days in a beautiful, localized, and scrollable
Jalali calendar UI.
[![pub package](https://img.shields.io/pub/v/flutter_persian_calendar.svg?color=%23e67e22&label=pub&logo=flutter_persian_calendar)](https://pub.dev/packages/flutter_persian_calendar)

---

## Features

- **Jalali Calendar**: All you need for selecting Persian (Jalali) dates.
- **Flexible UI**: Customizable background, primary, and secondary colors, plus text styles.
- **Configurable**: Pass your own `onDateChanged` callback, a `confirmButton`, or rely on defaults.
- **Scrolling**: Allows navigation across a wide date range via year, month, day views.
- **Built-in Localization**: Directionality is set to RTL automatically for Persian.

---

## Installation

1. Add this package to your `pubspec.yaml`:
   ```yaml
   dependencies:
     persian_calendar: ^0.0.3
   ```
2. Run `flutter pub get`.
3. Import it in your Dart code:
   ```dart
   import 'package:persian_calendar/persian_calendar.dart';
   ```

---

## Quick Start

Below is a minimal example showing how to embed the **PersianCalendar** widget in your app:

```dart
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart'; // or your Jalali library
import 'package:persian_calendar/persian_calendar.dart';

class CalendarExample extends StatelessWidget {
  const CalendarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persian Calendar Example')),
      body: Center(
        child: PersianCalendar(
          initialDate: Jalali(1402, 12, 25), // Optional: Defaults to Jalali.now()
          startingDate: Jalali(1300, 1, 1), // Optional range start
          endingDate: Jalali(1405, 1, 1), // Optional range end
          onDateChanged: (selectedDate) {
            debugPrint('Selected date: $selectedDate');
          },
        ),
      ),
    );
  }
}
```

This immediately displays a Jalali calendar that defaults to the specified `initialDate`. When the
user taps through the year, month, and day selections, `onDateChanged` will trigger with the final
date.

---

## Screenshot

Below is an example screenshot (layout and styling may vary based on theme and configuration):

![Persian Calendar Banner](sceenshots/banner.png?raw=true)

---

## Advanced Usage

### 1. Custom Height & Colors

If you need to tweak the height or change the colors:

```dart
PersianCalendar(
  height: 350.0,
  backgroundColor: Colors.grey.shade100,
  primaryColor: Colors.pink.shade200,
  secondaryColor: Colors.blue.shade200,
  textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
  onDateChanged: (selectedDate) {
  // do something interesting
  },
)
```

### 2. Custom Confirm Button

By default, if no `confirmButton` is provided, we show an `ElevatedButton` labeled "تایید". To inject
your own button:
```dart
PersianCalendar(
  onDateChanged: (selectedDate) {
  debugPrint('User picked: $selectedDate');
  },
  confirmButton: ElevatedButton(
  onPressed: () {
  // Close dialog or do something else
  debugPrint('User confirmed date selection');
  },
    child: const Text('Confirm'),
  ),
)
```
You decide how to handle the chosen date in your own UI flow.

### 3. Using in a Dialog
To place the `PersianCalendar` inside a dialog:
```dart
Future<void> _showPersianCalendarDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (dialogCtx) {
      return AlertDialog(
        content: PersianCalendar(
          onDateChanged: (jalaliDate) {
            debugPrint('Dialog - selected date: $jalaliDate');
          },
        ),
      );
    },
  );
}
```

Then call `_showPersianCalendarDialog(context)` from anywhere in your widget tree (e.g., a button tap).

---

## Contributing

- Feel free to submit pull requests or file issues.
- Add new features or improve the design.
- Don’t forget to star the repository if you find it helpful (stars are surprisingly motivating, even for Persian Calendars!).
