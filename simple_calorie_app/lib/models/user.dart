class User {
  final String id;
  final int calLimit; // The limit of calories for this user
  final DateTime since;

  User({this.id = '', this.calLimit = 2100, required this.since});

  User.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          since: DateTime.fromMillisecondsSinceEpoch(json['since'] as int),
          calLimit: json['calLimit'] as int,
        );

  Map<String, Object> toJson() {
    return {
      'since': since.millisecondsSinceEpoch,
      'calLimit': calLimit,
    };
  }

  User copyWith({id, calLimit, since}) {
    return User(
        id: id ?? this.id,
        calLimit: calLimit ?? this.calLimit,
        since: since ?? this.since);
  }
}
