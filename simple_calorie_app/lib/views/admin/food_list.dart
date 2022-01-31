import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/views/admin/user_foods.dart';
import 'package:simple_calorie_app/views/bnbpv.dart';
import 'package:get/get.dart';

import '../create_food_entry.dart';

class AdminFoodList extends StatelessWidget {
  const AdminFoodList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => const CreateFoodEntry()),
      ),
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.off(() => BNBPV());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: /*GetBuilder<FoodController>(
        builder: (interface) {
          return*/
          FutureBuilder(
        future: foodController.getAdminFoodEntries(),
        builder: (_, AsyncSnapshot<Map<String, List<FoodEntry>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data!.isNotEmpty) {
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
