enum MeasurementUnit {
  seconds,
  repetitions,
  meters;

  @override
  String toString() {
    return name;
  }

  static MeasurementUnit fromString(String value) {
    return switch (value) {
      "seconds" => seconds,
      "repetitions" => repetitions,
      "meters" => meters,
      String() => throw ArgumentError(),
    };
  }
}

const seconds = MeasurementUnit.seconds;
const repetitions = MeasurementUnit.repetitions;
const meters = MeasurementUnit.meters;
