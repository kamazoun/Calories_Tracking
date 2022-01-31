class FoodEntry {
  final String id;
  final DateTime time; // The time at which the food was eaten
  final String userId;
  //final String foodId;
  final String foodName;
  final String photoUrl;
  final int calories;

  FoodEntry(
      {this.id = '',
      required this.time,
      required this.userId,
      required this.foodName,
      required this.photoUrl,
      required this.calories});

  FoodEntry.fromJson(String id, Map<String, dynamic>? json)
      : this(
          id: id, //json != null ? json['id'] as String : '',
          time: json != null
              ? DateTime.fromMillisecondsSinceEpoch(json['time'] as int)
              : DateTime.now(),
          userId: json != null ? json['userId'] as String : '',
          foodName: json != null ? json['foodName'] as String : '',
          photoUrl: json != null
              ? json['photoUrl'] as String
              : '', // TODO: default food url
          calories: json != null ? json['calories'] as int : 2100,
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
