import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/utils/global.dart';

class FoodEntryItem extends StatefulWidget {
  const FoodEntryItem({required this.key, required this.foodEntry})
      : super(key: key);
  final FoodEntry foodEntry;
  final ValueKey key;

  @override
  State<FoodEntryItem> createState() => _FoodEntryItemState();
}

class _FoodEntryItemState extends State<FoodEntryItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key,
      onDismissed: _dismiss,
      confirmDismiss: _confirmDismiss,
      background:
          Container(color: Colors.green, child: const Icon(Icons.update)),
      secondaryBackground: Container(
          color: Colors.red, child: const Icon(Icons.delete_sweep_outlined)),
      child: SizedBox(
        //height: 200,
        child: ListTile(
          leading: widget.foodEntry.photoUrl.isNotEmpty
              ? SizedBox(
                  width: Get.width / 4,
                  child: Image.network(
                    widget.foodEntry.photoUrl,
                    height: 100,
                  ),
                )
              : SizedBox(
                  width: Get.width / 4,
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/calorie-app-toptal54648.appspot.com/o/plate.jpg?alt=media&token=1cc5223f-6b3c-41de-b50b-4bfc161d541f',
                    height: 100,
                  ),
                ),
          title: Text(widget.foodEntry.foodName),
          trailing: Text('${widget.foodEntry.calories} Calories'),
          subtitle: Text(
              '${mapWeekDay(widget.foodEntry.time.weekday)} ${widget.foodEntry.time.toLocal().toString().substring(0, 10)}'),
        ),
      ),
    );
  }

  _dismiss(DismissDirection direction) async {
    FoodController foodController = Get.find<FoodController>();
    if (direction == DismissDirection.endToStart) {
      await foodController.deleteFoodEntry(widget.foodEntry);
    }
  }

  Future<bool> _confirmDismiss(direction) async {
    if (direction == DismissDirection.endToStart) // to delete
    {
      return await Get.defaultDialog(
        title: 'Confirm Delete ?',
        content: const Text('The operation cannot be reversed'),
        onConfirm: () {
          Get.back(result: true);
        },
        onCancel: () => Get.back(result: false),
      );
    }
    return true;
  }
}
