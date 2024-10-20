// ignore: non_constant_identifier_names
// ignore_for_file: avoid_print, argument_type_not_assignable_to_error_handler

import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/auth/users_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: non_constant_identifier_names

pickDateTimeRange(BuildContext context) {
  DateTimeRange(start: DateTime.now(), end: DateTime.now());
// ignore: unused_local_variable
  Future<DateTimeRange?> newDateRange = showDateRangePicker(
      context: context, firstDate: DateTime(200), lastDate: DateTime.now());
}

Future<void> permission() async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    await Permission.manageExternalStorage.request();
  }
  var status1 = await Permission.storage.status;
  if (!status1.isGranted) {
    await Permission.storage.request();
  }
}

List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(DateTime(
        startDate.year,
        startDate.month,
        // In Dart you can set more than. 30 days, DateTime will do the trick
        startDate.day + i));
  }
  return days;
}

bool permitionss(BuildContext context, UserPermition permition) {
  var test = currentuser!.permitions
      .where((e) => e == permition.getTitle || e == "show_all");

  if (test.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

bool permitionssForOne(BuildContext context, UserPermition permition) {
  var test = currentuser!.permitions.where((e) => e == permition.getTitle);

  if (test.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
