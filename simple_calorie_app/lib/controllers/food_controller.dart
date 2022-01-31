import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/db/food_entry_firebase.dart';
import 'package:simple_calorie_app/models/food_entry.dart';

class FoodController extends GetxController {
  late final RxList<FoodEntry> _foodEntries = RxList<FoodEntry>([]);

  List<FoodEntry> get foodEntries =>
      (from == null && to == null) ? _foodEntries : filteredFoodEntries();

  DateTime? from;
  DateTime? to;

  FoodController() {
    _setUserFoods();
  }

  Future<void> _setUserFoods() async {
    /*final userId = FirebaseAuth.instance.currentUser!
        .uid; // I can guarantee this as anonymous auth will be performed if user is not signed in
*/
    final foodEntries = await FoodEntryFirebase.getAllFoodEntries();
    _foodEntries.addAll(foodEntries);
  }

  List<FoodEntry> filteredFoodEntries() {
    from = from ?? DateTime(2022);
    to = to ?? DateTime.now();

    return foodEntries
        .where((fE) => fE.time.isAfter(from!) && fE.time.isBefore(to!))
        .toList();
  }

  createFoodEntry(foodEntry) {
    final uid = FirebaseAuth.instance.currentUser!
        .uid; // I can guarantee this as anonymous auth will be performed if user is not signed in

    FoodEntryFirebase.createFoodEntry(foodEntry, uid);

    _foodEntries.add(foodEntry);
    update();
  }

  setFrom(DateTime val) {
    from = val;
    update();
  }

  setTo(DateTime val) {
    to = val;
    update();
  }

  int getWeeklyCalories() {
    int count = 0;
    for (var food in foodEntries) {
      if (DateTime.now().difference(food.time) <= const Duration(days: 7)) {
        count += food.calories;
      }
    }
    return count;
  }

  List<Map> excessDays() {
    Map<int, List<FoodEntry>> excess = {};
    Map<int, int> count = {};
    for (var food in foodEntries) {
      if (DateTime.now().difference(food.time) <= const Duration(days: 7)) {
        if (null == excess[food.time.day]) {
          excess[food.time.day] = [];
          count[food.time.day] = 0;
        }
        excess[food.time.day]!.add(food);
        count[food.time.day] = count[food.time.day]! + food.calories;
      }
    }
    return [excess, count];
  }

  Future<Map<String, List<FoodEntry>>> getAdminFoodEntries() async {
    Map<String, List<FoodEntry>> usersFoods = {};
    QuerySnapshot<Map<String, dynamic>> results =
        await FirebaseFirestore.instance.collection('foodEntries').get();

    for (QueryDocumentSnapshot element in results.docs) {
      final QuerySnapshot userFoodSnap =
          await element.reference.collection('userData').get();

      final List<FoodEntry> userFoods = userFoodSnap.docs
          .map((QueryDocumentSnapshot e) =>
              FoodEntry.fromJson(e.id, e.data() as Map<String, dynamic>))
          .toList();

      usersFoods[element.id] = userFoods;
    }

    return usersFoods;
  }
}
