import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_calorie_app/controllers/auth_controller.dart';
import 'package:simple_calorie_app/controllers/food_controller.dart';
import 'package:simple_calorie_app/models/food_entry.dart';
import 'package:simple_calorie_app/utils/global.dart';

class CreateFoodEntry extends StatefulWidget {
  const CreateFoodEntry({Key? key}) : super(key: key);

  @override
  State<CreateFoodEntry> createState() => _CreateFoodEntryState();
}

class _CreateFoodEntryState extends State<CreateFoodEntry> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController caloriesController = TextEditingController();

  XFile? selected;

  final _formKey = GlobalKey<FormState>();

  late FocusNode caloriesFocusNode;

  @override
  void initState() {
    super.initState();

    caloriesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    caloriesFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new food entry'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>
                  createFoodEntry(context, authController, foodController),
              icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: Get.width / 7),
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  controller: nameController,
                  decoration: kInputDecoration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    caloriesFocusNode.requestFocus();
                  },
                ),
                TextFormField(
                  focusNode: caloriesFocusNode,
                  controller: caloriesController,
                  keyboardType: TextInputType.number,
                  decoration: kInputDecoration.copyWith(
                      hintText: 'Please Enter Calories Content',
                      labelText: 'Energetic value',
                      suffixText: 'Cal'),
                  validator: (value) {
                    if (value?.trim() == null || value!.isEmpty) {
                      return 'Please enter some value';
                    }
                    if (null == int.tryParse(value.trim())) {
                      return 'Please enter a valid whole number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: selected == null
                      ? IconButton(
                          onPressed: () async {
                            final XFile? r = await ImagePicker()
                                .pickImage(source: ImageSource.camera);

                            if (mounted) {
                              setState(() {
                                selected = r;
                              });
                            }
                          },
                          icon: const Icon(Icons.camera, size: 100),
                        )
                      : Image.file(File(selected!.path)),
                ),
                ElevatedButton.icon(
                    onPressed: () => createFoodEntry(
                          context,
                          authController,
                          foodController,
                        ),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Food Entry'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  createFoodEntry(context, authController, foodController) async {
    if (_formKey.currentState!.validate()) {
      final uid = authController.user?.uid ?? await authController.userId;
      String photoUrl = '';
      if (null != selected) {
        try {
          final UploadTask uploadTask = FirebaseStorage.instance
              .ref('$uid/${selected!.path}.jpg')
              .putFile(File(selected!.path));

          final downloadUrl = await (await uploadTask.whenComplete(() => null))
              .ref
              .getDownloadURL();
          photoUrl = downloadUrl.toString();
        } on FirebaseException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occurred')),
          );
        }
      }

      foodController.createFoodEntry(FoodEntry(
          time: DateTime.now(),
          userId: uid,
          foodName: nameController.text.trim(),
          photoUrl:
              'https://firebasestorage.googleapis.com/v0/b/calorie-app-toptal54648.appspot.com/o/pizza.jpeg?alt=media&token=5adc6b0c-2c6c-4cbe-ae91-9c1ac2ba6c3f', //photoUrl,
          calories: int.parse(caloriesController.text.trim())));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      Get.back();
    }
  }
}
