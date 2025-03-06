import 'package:floor/floor.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/solo_local_db/exercises.dart';

@Entity(tableName: 'workout_plan')
class WorkoutPlan {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;

  String url;

  WorkoutPlan({this.id, this.url = '', required this.name});

  WorkoutPlan.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, dynamic> toJson() => {'name': name, 'url': url};

  Future<List<Exercise>> exercises(Exercises provider) {
    return provider.getExercisesByWorkoutPlanId(id!);
  }

  @override
  String toString() {
    return name;
  }
}
