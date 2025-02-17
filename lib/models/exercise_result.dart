import 'package:homework/models/exercise.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/typedefs/output.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'exercise_result', foreignKeys: [
  ForeignKey(
      childColumns: ['workout_id'], parentColumns: ['id'], entity: Workout)
])
class ExerciseResult {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'workout_id')
  int? workoutId;

  Output actualOutput;
  Output targetOutput;
  String exerciseName;
  MeasurementUnit measurementUnit;

  ExerciseResult(
      {this.id,
      this.workoutId,
      required this.actualOutput,
      required this.targetOutput,
      required this.exerciseName,
      required this.measurementUnit});

  Exercise get exercise =>
      Exercise(name: exerciseName, target: targetOutput, unit: measurementUnit);

  @override
  String toString() {
    return 'Exercise: ($exercise), actual: $actualOutput';
  }
}
