import 'package:homework/models/exercise_result.dart';
import 'package:date_only/date_only.dart';

class Workout {
  DateOnly date;
  List<ExerciseResult> results;

  Workout({
    required this.date,
    required this.results,
  });

  @override
  String toString() {
    return 'Workout: $date\n${results.join('\n')}';
  }
}