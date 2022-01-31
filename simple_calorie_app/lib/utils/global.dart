import 'package:flutter/material.dart';

const kAppTitle = 'Calorie App';

const kInputDecoration = InputDecoration(
    labelText: 'Name',
    contentPadding: EdgeInsets.all(10),
    hintText: 'Please Enter Food Name');

String mapWeekDay(int weekDay) {
  String r = '';
  switch (weekDay) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
  }
  return r;
}

class GlobalFirebaseConfig {
  static const password = '1234';
}
