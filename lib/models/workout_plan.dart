import 'package:floor/floor.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/solo_local_db/exercises.dart';

@Entity(tableName: 'workout_plan')
class WorkoutPlan {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String name;

  String url;

  WorkoutPlan({this.id, required this.name, required this.url});

  WorkoutPlan.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'],
        id = json['id'];

  Map<String, dynamic> toJson() => {'name': name, 'url': url, 'id': id};

  Future<List<Exercise>> exercises(Exercises provider) {
    return provider.getExercisesByWorkoutPlanId(id!);
  }

  @override
  String toString() {
    return name;
  }
}
