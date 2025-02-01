import 'package:homework/models/exercise_result.dart';

class Workout {
  DateTime date;
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

extension MonthDayYearFormat on DateTime {
  String formatMonthDayYear() {
    return '$month/$day/$year';
  }
}