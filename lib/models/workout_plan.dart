import 'package:floor/floor.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/models/exercise.dart';

@Entity(tableName: 'workout_plan')
class WorkoutPlan {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;

  Future<List<Exercise>> exercises(ExerciseProvider provider) {
    return provider.getExercisesByWorkoutPlanId(id!);
  }

  WorkoutPlan({this.id, required this.name});

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(name: json['name']);
  }

  @override
  String toString() {
    return name;
  }
}
