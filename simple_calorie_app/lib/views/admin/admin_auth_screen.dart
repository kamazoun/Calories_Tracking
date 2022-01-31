import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/utils/global.dart';

import 'food_list.dart';

class AdminAuthScreen extends StatelessWidget {
  AdminAuthScreen({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Text('Please enter admin password:'),
              TextFormField(
                controller: passwordController,
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (passwordController.text.trim() ==
                        GlobalFirebaseConfig.password) {
                      Get.off(() => const AdminFoodList());
                    }
                  },
                  child: const Text('Get in admin'))
            ],
          ),
        ),
      ),
    );
  }
}
