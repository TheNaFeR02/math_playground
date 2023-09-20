class OperationLevel {
  final String name;
  final int level;

  OperationLevel({required this.name, required this.level});

  factory OperationLevel.fromJson(Map<String, dynamic> json) {
    return OperationLevel(
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level,
      };

  @override
  String toString() {
    return '$name, level: $level';
  }
}
