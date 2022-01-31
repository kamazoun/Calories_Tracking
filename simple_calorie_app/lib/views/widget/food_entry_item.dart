import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/utils/global.dart';

class FoodEntryItem extends StatelessWidget {
  const FoodEntryItem({Key? key, required this.foodEntry}) : super(key: key);
  final FoodEntry foodEntry;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(foodEntry.id),
      onDismissed: _dismiss,
      background:
          Container(color: Colors.green, child: const Icon(Icons.update)),
      secondaryBackground: Container(
          color: Colors.red, child: const Icon(Icons.delete_sweep_outlined)),
      child: SizedBox(
        //height: 200,
        child: ListTile(
          leading: foodEntry.photoUrl.isNotEmpty
              ? Image.network(
                  foodEntry.photoUrl,
                  height: 100,
                )
              : Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/calorie-app-toptal54648.appspot.com/o/plate.jpg?alt=media&token=1cc5223f-6b3c-41de-b50b-4bfc161d541f',
                  height: 100,
                ),
          title: Text(foodEntry.foodName),
          trailing: Text('${foodEntry.calories} Calories'),
          subtitle: Text(
              '${mapWeekDay(foodEntry.time.weekday)} ${foodEntry.time.toLocal().toString().substring(0, 10)}'),
        ),
      ),
    );
  }

  _dismiss(DismissDirection direction) {
    FoodController foodController = Get.find<FoodController>();
    if (direction == DismissDirection.endToStart) {
      foodController.deleteFoodEntry(foodEntry);
    }
  }
}
