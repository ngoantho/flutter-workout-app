import 'package:floor/floor.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/solo_local_db/solo_exercises.dart';

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

  WorkoutPlan.fromJson(Map<String, dynamic> json, this.url)
      : name = json['name'];

  @override
  String toString() {
    return name;
  }
}
