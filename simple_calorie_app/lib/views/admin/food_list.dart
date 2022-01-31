import 'package:flutter/material.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/views/widget/food_entry_item.dart';
import 'package:get/get.dart';

class AdminFoodList extends StatelessWidget {
  const AdminFoodList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        centerTitle: true,
      ),
      body: GetBuilder<FoodController>(
        builder: (interface) {
          return FutureBuilder(
              future: interface.getAdminFoodEntries(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final Map<String, List<FoodEntry>> data =
                      snapshot.data! as Map<String, List<FoodEntry>>;
                  print(data.values);
                  return ListView.separated(
                    itemBuilder: (context, index) =>
                        FoodEntryItem(foodEntry: data.values.first[index]),
                    itemCount: data.values.first.length,
                    separatorBuilder: (__, _) => const SizedBox(height: 25),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              });
        },
      ),
    );
  }
}

class UserFoods extends StatelessWidget {
  const UserFoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
