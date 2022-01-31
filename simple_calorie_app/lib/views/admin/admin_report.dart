import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';

class AdminReport extends StatelessWidget {
  const AdminReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(),
                children: [
                  const TableRow(children: [
                    Center(child: Text('Entries this week')),
                    Center(child: Text('Previous week entries')),
                  ]),
                  TableRow(children: [
                    FutureBuilder(
                        future: foodController.getWeekEntries(),
                        builder: (_, AsyncSnapshot<int> fsnapshot) {
                          if (fsnapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(child: Text('${fsnapshot.data}'));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                    FutureBuilder(
                        future: foodController.getLastWeekEntries(),
                        builder: (_, AsyncSnapshot<int> fsnapshot) {
                          if (fsnapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(child: Text('${fsnapshot.data}'));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ]),
                ],
              ),
              const Divider(),
              Table(
                border: TableBorder.all(),
                children: [
                  const TableRow(children: [
                    Center(
                        child: Text(
                            'Weekly average number of calories added per user')),
                  ]),
                  TableRow(children: [
                    FutureBuilder(
                        future: foodController.getWeekAverage(),
                        builder: (_, AsyncSnapshot<double> fsnapshot) {
                          if (fsnapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(child: Text('${fsnapshot.data}'));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
