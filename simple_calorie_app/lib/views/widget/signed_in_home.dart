import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';

import 'food_entry_item.dart';

class SignedInHome extends StatefulWidget {
  const SignedInHome({
    Key? key,
  }) : super(key: key);

  @override
  State<SignedInHome> createState() => _SignedInHomeState();
}

class _SignedInHomeState extends State<SignedInHome> {
  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          flex: 1,
          child: GetBuilder<FoodController>(
            builder: (fc) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'From Date: ${fc.from.value.month}/${fc.from.value.day}th'),
                Text('To Date: ${fc.to.value.month}/${fc.to.value.day}th'),
              ],
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () async {
                      final DateTime? r = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now(),
                      );
                      if (null != r) {
                        foodController.setFrom(r);
                      }
                    },
                    child: Text('Select Date From')),
                TextButton(
                    onPressed: () async {
                      final DateTime? r = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now(),
                      );
                      if (null != r) {
                        foodController.setTo(r);
                      }
                    },
                    child: const Text('Select Date To')),
              ],
            )),
        Flexible(
          flex: 7,
          child: GetX<FoodController>(
            builder: (interface) => ListView.separated(
              itemBuilder: (context, index) => FoodEntryItem(
                  key: ValueKey(interface.foodEntriesFiltered[index].id),
                  foodEntry: interface.foodEntriesFiltered[index]),
              itemCount: interface.foodEntriesFiltered.length,
              separatorBuilder: (__, _) => const SizedBox(height: 25),
            ),
          ),
        ),
      ],
    );
  }
}
