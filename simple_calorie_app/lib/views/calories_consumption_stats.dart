import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/auth_controller.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/utils/global.dart';

class CalorieConsumptionStats extends StatelessWidget {
  const CalorieConsumptionStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Table(
            columnWidths: const {0: FractionColumnWidth(2 / 3)},
            border: TableBorder.all(color: Colors.grey),
            children: [
              TableRow(children: [
                const TableCell(
                    child: Text(
                        'Quantity of calories consumed during the last 7 days: ')),
                TableCell(child: Text('${foodController.getWeeklyCalories()}'))
              ])
            ],
          ),
          const Divider(),
          DataTable(columns: const [
            DataColumn(label: Text('Day')),
            DataColumn(label: Text('Calories Consumed'))
          ], rows: _buildDataRow(foodController))
        ],
      ),
    );
  }

  _buildDataRow(FoodController foodController) {
    final authController = Get.find<AuthController>();
    final r = foodController.excessDays();
    final Map<int, List<FoodEntry>> excess = r[0] as Map<int, List<FoodEntry>>;
    final Map<int, int> count = r[1] as Map<int, int>;

    List<DataRow> rows = [];
    for (var index in count.keys) {
      if (count[index]! > (authController.userModel?.calLimit ?? 2100)) {
        rows.add(DataRow(cells: [
          DataCell(Text(
              '${mapWeekDay(excess[index]!.first.time.weekday)} ${index}th')),
          DataCell(
            SingleChildScrollView(
              child: Column(
                children: excess[index]!
                    .map((e) => Text('${e.foodName}: ${e.calories} calories'))
                    .toList(),
              ),
            ),
          )
        ]));
      }
    }
    return rows;
  }
}
