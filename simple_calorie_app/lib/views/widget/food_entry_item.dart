import 'package:flutter/material.dart';
import 'package:simple_calorie_app/models/food_entry.dart';

class FoodEntryItem extends StatelessWidget {
  const FoodEntryItem({Key? key, required this.foodEntry}) : super(key: key);
  final FoodEntry foodEntry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
      ),
    );
  }
}
