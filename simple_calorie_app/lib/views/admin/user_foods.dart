import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/views/widget/food_entry_item.dart';
import 'package:get/get.dart';

class UserFoods extends StatelessWidget {
  const UserFoods({Key? key, required this.uid, required this.foodEntries})
      : super(key: key);
  final String uid;
  final List<FoodEntry> foodEntries;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('User: ${uid.substring(0, 5)}'),
        ...foodEntries
            .map((e) => FoodEntryItem(key: ValueKey(e.id), foodEntry: e))
            .toList(),
      ]),
    );
  }
}
