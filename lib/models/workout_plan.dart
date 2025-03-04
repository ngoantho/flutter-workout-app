import 'package:floor/floor.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/models/exercise.dart';

@Entity(tableName: 'workout_plan')
class WorkoutPlan {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;

  String url;

  Future<List<Exercise>> exercises(Exercises provider) {
    return provider.getExercisesByWorkoutPlanId(id!);
  }

  WorkoutPlan({this.id, this.url = '', required this.name});

  factory WorkoutPlan.fromJson(Map<String, dynamic> json, String url) {
    return WorkoutPlan(name: json['name'], url: url);
  }

  @override
  String toString() {
    return name;
  }
}
