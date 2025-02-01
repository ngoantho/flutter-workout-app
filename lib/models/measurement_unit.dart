enum MeasurementUnit {
  seconds,
  repetitions,
  meters;

  @override
  String toString() {
    return name;
  }
}

const seconds = MeasurementUnit.seconds;
const repetitions = MeasurementUnit.repetitions;
const meters = MeasurementUnit.meters;
