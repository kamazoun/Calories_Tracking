import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'food_list.dart';

class AdminAuthScreen extends StatelessWidget {
  const AdminAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Please enter admin password:'),
            TextFormField(
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.off(const AdminFoodList());
                },
                child: const Text('Get in admin'))
          ],
        ),
      ),
    );
  }
}
