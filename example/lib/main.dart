import 'package:flutter/material.dart';
import 'package:flutter_persian_calendar/flutter_persian_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Vazirmatn',
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Jalali selectedDate = Jalali(1376, 1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Shamsi Date Calendar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'selected Date: $selectedText',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: shamsiDateCalendarWidget(context),
                    );
                  },
                );
              },
              child: const Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }

  PersianCalendar shamsiDateCalendarWidget(BuildContext context) {
    return PersianCalendar(
      selectedDate: selectedDate,
      onDateChanged: (newDate) {
        setState(() {
          selectedDate = newDate;
        });
      },
      onConfirmButtonPressed: () {
        Navigator.pop(context);
      },
      datePickerStartDate: Jalali(1300, 4, 12),
      datePickerEndDate: Jalali(1402, 7, 10),
      calendarTheme: persianDarkTheme,
    );
  }

  String get selectedText =>
      '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}';
}
