import 'package:floor/floor.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/models/exercise.dart';

@Entity(tableName: 'workout_plan')
class WorkoutPlan {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;

  Future<List<Exercise>> exercises(ExerciseDao dao) {
    return dao.getExercisesByWorkoutPlanId(id!);
  }

  WorkoutPlan({this.id, required this.name});

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(name: json['name']);
  }

  // factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
  //   List<Exercise> exercises = List.from(json['exercises']).map(
  //     (e) {
  //       final exercise = Exercise(
  //         name: e['name'],
  //         target: Output(e['target']),
  //         unit: MeasurementUnit.fromString(e['unit']),
  //       );
  //       debugPrint(exercise.toString());
  //       return exercise;
  //     },
  //   ).toList();
  //   return WorkoutPlan(name: json['name'], exercises: exercises);
  // }
}
