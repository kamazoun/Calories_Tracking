import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/db/food_entry_firebase.dart';
import 'package:simple_calorie_app/models/food_entry.dart';

class FoodController extends GetxController {
  late final RxList<FoodEntry> _foodEntries = RxList<FoodEntry>([]);

  List<FoodEntry> get foodEntries => _foodEntries();

  RxList<FoodEntry> get foodEntriesFiltered => filteredFoodEntries();

  Rx<DateTime> from = Rx(DateTime(2022));
  Rx<DateTime> to = Rx(DateTime.now());

  FoodController() {
    _setUserFoods();
    //setFrom(DateTime(2022));
    //setTo(DateTime.now());
  }

  Future<void> _setUserFoods() async {
    /*final userId = FirebaseAuth.instance.currentUser!
        .uid; // I can guarantee this as anonymous auth will be performed if user is not signed in
*/
    final foodEntries = await FoodEntryFirebase.getAllFoodEntries();
    _foodEntries.addAll(foodEntries);
  }

  RxList<FoodEntry> filteredFoodEntries() {
    return foodEntries
        .where((fE) =>
            fE.time.isAfter(from.value) &&
            fE.time.isBefore(to.value.add(const Duration(days: 1))))
        .toList()
        .obs;
  }

  createFoodEntry(foodEntry) {
    final uid = FirebaseAuth.instance.currentUser!
        .uid; // I can guarantee this as anonymous auth will be performed if user is not signed in

    FoodEntryFirebase.createFoodEntry(foodEntry, uid);

    _foodEntries.add(foodEntry);
    update();
  }

  setFrom(DateTime val) {
    from.value = val;
    update();
  }

  setTo(DateTime val) {
    to.value = val;
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
    List<FoodEntry> results = await FoodEntryFirebase.getAdminFoodEntries();

    List<String> done = [];

    for (FoodEntry food in results) {
      if (done.contains(food.userId)) {
        continue;
      }
      final List<FoodEntry> userFoods =
          results.where((element) => element.userId == food.userId).toList();

      usersFoods[food.userId] = userFoods;
      done.add(food.userId);
    }

    return usersFoods;
  }

  Future<void> deleteFoodEntry(FoodEntry foodEntry) async {
    await FoodEntryFirebase.deleteFoodEntry(foodEntry);

    //_foodEntries.remove(foodEntry);
    _foodEntries.remove;
    update();
  }
}
