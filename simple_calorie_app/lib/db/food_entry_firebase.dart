import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/models/food_entry.dart';

class FoodEntryFirebase {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _foodEntriesRef = _firestore
      .collection('foodEntries')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('userData')
      .withConverter<FoodEntry>(
        fromFirestore: (snapshot, _) =>
            FoodEntry.fromJson(snapshot.id, snapshot.data()),
        toFirestore: (foodEntry, _) => foodEntry.toJson(),
      );

  static final CollectionReference _adminFoodEntries =
      _firestore.collection('adminFoodEntries').withConverter<FoodEntry>(
            fromFirestore: (snapshot, _) =>
                FoodEntry.fromJson(snapshot.id, snapshot.data()),
            toFirestore: (foodEntry, _) => foodEntry.toJson(),
          );

  static _catchError(error) =>
      Get.snackbar('An Error Occurred', 'Please try again later!');

  static Future createFoodEntry(FoodEntry foodEntry, String uid) async {
    final DocumentReference r = await _foodEntriesRef.add(foodEntry);

    await _adminFoodEntries.doc(r.id).set(foodEntry.copyWith(id: r.id));

    return r;
  }

  static Future deleteFoodEntry(FoodEntry foodEntry) async {
    await _firestore
        .collection('foodEntries')
        .doc(foodEntry.userId)
        .collection('userData')
        .doc(foodEntry.id)
        .delete();

    await _adminFoodEntries.doc(foodEntry.id).delete();
  }

  static Future<List<FoodEntry>> getAllFoodEntries() async {
    List<QueryDocumentSnapshot<FoodEntry>> foodEntries = await _foodEntriesRef
        .orderBy('calories')
        .get()
        .then((QuerySnapshot<Object?> snapshot) =>
            snapshot.docs as List<QueryDocumentSnapshot<FoodEntry>>);

    return foodEntries.map((e) => e.data()).toList();
    /* .map((QueryDocumentSnapshot e) =>
            FoodEntry.fromJson(e.id, e.data() as Map<String, Object?>))
        .toList();*/
  }

  static Future<FoodEntry> getFoodEntry(String id) async {
    Map<String, dynamic> foodEntry = await _foodEntriesRef.doc(id).get().then(
        (DocumentSnapshot<Object?> snapshot) =>
            snapshot.data() as Map<String, dynamic>);

    return FoodEntry.fromJson(id, foodEntry);
  }

  static Future<List<FoodEntry>> getAdminFoodEntries() async {
    final List<QueryDocumentSnapshot<Object?>> foodsSnap =
        await _adminFoodEntries
            .orderBy('userId')
            .get()
            .then((QuerySnapshot<Object?> snapshot) => snapshot.docs)
            .catchError(_catchError);

    return foodsSnap
        .map((QueryDocumentSnapshot e) => e.data() as FoodEntry)
        .toList();
  }
}
