import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/controllers/auth_controller.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/firebase_options.dart';
import 'package:simple_calorie_app/utils/global.dart';
import 'package:simple_calorie_app/views/bnbpv.dart';
import 'package:simple_calorie_app/views/home.dart';

void main() async {
  await _initialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BNBPV(),
    );
  }
}

Future<void> _initialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  Get.put(FoodController());
}
