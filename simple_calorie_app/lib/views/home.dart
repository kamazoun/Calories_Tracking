import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/auth_controller.dart';
import 'package:simple_calorie_app/views/widget/signed_in_home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return null != authController.user
        ? const SignedInHome()
        : FutureBuilder(
            future: authController.signInAnonymously(),
            builder: (_, AsyncSnapshot futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.done) {
                return const SignedInHome();
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
  }
}
