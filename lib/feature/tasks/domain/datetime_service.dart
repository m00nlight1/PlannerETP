import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeService {
  static Future<DateTime> selectDate(
      BuildContext context, DateTime selectedDate) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
      locale: const Locale("ru", "RU"),
    );
    if (selected != null && selected != selectedDate) {
      return selected;
    }
    return selectedDate;
  }

  static bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  static Future<TimeOfDay> selectTime(
      BuildContext context, TimeOfDay? selectedTime) async {
    final currentTime = DateTime.now();
    final initialTime = selectedTime ?? TimeOfDay.fromDateTime(currentTime);
    final selected = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selected != null) {
      final selectedDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        selected.hour,
        selected.minute,
      );

      if (selectedDateTime.isAfter(currentTime)) {
        return selected;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Выберите будущее время')),
        );
      }
    }

    return selectedTime ?? initialTime;
  }

  static Future<void> selectEndWorkDateTime(BuildContext context,
      DateTime endWorkDateTime, Function(DateTime) setEndWorkDateTime) async {
    final date = await selectDate(context, endWorkDateTime);
    final time =
        await selectTime(context, TimeOfDay.fromDateTime(endWorkDateTime));

    setEndWorkDateTime(DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ));
  }

  static Future<void> selectStartWorkDateTime(
      BuildContext context,
      DateTime startWorkDateTime,
      Function(DateTime) setStartWorkDateTime) async {
    final date = await selectDate(context, startWorkDateTime);
    final time =
        await selectTime(context, TimeOfDay.fromDateTime(startWorkDateTime));

    setStartWorkDateTime(DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ));
  }

  String getStartWorkDateTime(DateTime startWorkDateTime) =>
      DateFormat('yyyy-MM-dd – kk:mm').format(startWorkDateTime);

  String getEndWorkDateTime(DateTime endWorkDateTime) =>
      DateFormat('yyyy-MM-dd – kk:mm').format(endWorkDateTime);
}
