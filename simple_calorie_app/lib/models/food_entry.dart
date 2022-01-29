class FoodEntry {
  final String id;
  final DateTime time; // The time at which the food was eaten
  final String userId;
  //final String foodId;
  final String foodName;
  final String photoUrl;
  final double calories;

  FoodEntry(
      {this.id = '',
      required this.time,
      required this.userId,
      required this.foodName,
      required this.photoUrl,
      required this.calories});

  FoodEntry.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          time: DateTime.fromMillisecondsSinceEpoch(json['time'] as int),
          userId: json['userId'] as String,
          foodName: json['foodName'] as String,
          photoUrl: json['photoUrl'] as String,
          calories: json['calories'] as double,
        );

  Map<String, Object> toJson() {
    return {
      'time': time.millisecondsSinceEpoch,
      'foodName': foodName,
      'userId': userId,
      'photoUrl': photoUrl,
      'calories': calories,
    };
  }

  FoodEntry copyWith({id, foodName, userId, calories, time, photoUrl}) {
    return FoodEntry(
        id: id ?? this.id,
        foodName: foodName ?? this.foodName,
        calories: calories ?? this.calories,
        userId: userId ?? this.userId,
        photoUrl: photoUrl ?? this.photoUrl,
        time: time ?? this.time);
  }
}
