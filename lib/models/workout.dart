import 'package:homework/models/exercise_result.dart';

class Workout {
  DateTime date;
  List<ExerciseResult> results;

  Workout({
    required this.date,
    required this.results,
  });
}