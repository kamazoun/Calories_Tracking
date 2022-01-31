import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/views/widget/food_entry_item.dart';
import 'package:get/get.dart';

class AdminFoodList extends StatelessWidget {
  const AdminFoodList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
        actions: [],
      ),
      body: /*GetBuilder<FoodController>(
        builder: (interface) {
          return*/
          FutureBuilder(
        future: foodController.getAdminFoodEntries(),
        builder: (_, AsyncSnapshot<Map<String, List<FoodEntry>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final Map<String, List<FoodEntry>> data = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) => UserFoods(
                  uid: data.keys.toList()[index],
                  foodEntries: data.values.toList()[index]),
              itemCount: data.length,
              separatorBuilder: (__, _) => const SizedBox(height: 25),
            );
          } else {
            return Column(
              children: const [
                Text('Seems like there is no data yet!'),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: LinearProgressIndicator(),
                ),
              ],
            );
          }
          /* });*/
        },
      ),
    );
  }
}

class UserFoods extends StatelessWidget {
  const UserFoods({Key? key, required this.uid, required this.foodEntries})
      : super(key: key);
  final String uid;
  final List<FoodEntry> foodEntries;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Text('User: $uid'),
        ...foodEntries.map((e) => FoodEntryItem(foodEntry: e)).toList(),
      ]),
    );
  }
}
