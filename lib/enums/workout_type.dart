enum WorkoutType {
  solo,
  collaborative,
  competitive;

  @override
  String toString() {
    return name;
  }

  static WorkoutType fromString(String value) {
    return switch (value) {
      "solo" => solo,
      "collaborative" => collaborative,
      "competitive" => competitive,
      String() => throw ArgumentError(),
    };
  }
}

const solo = WorkoutType.solo;
const collaborative = WorkoutType.collaborative;
const competitive = WorkoutType.competitive;
