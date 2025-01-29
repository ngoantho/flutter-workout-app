import 'package:homework/models/exercise.dart';

class WorkoutPlan {
  final String name;
  final List<Exercise> exercises;

  const WorkoutPlan({required this.name, required this.exercises});
}
