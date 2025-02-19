import 'package:floor/floor.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/models/exercise_result.dart';

@Entity(tableName: 'workout')
class Workout {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'workout_day')
  int workoutDay;

  @ColumnInfo(name: 'workout_month')
  int workoutMonth;

  @ColumnInfo(name: 'workout_year')
  int workoutYear;

  Workout(
      {this.id,
      required this.workoutDay,
      required this.workoutMonth,
      required this.workoutYear});

  Workout.fromDate({this.id, required DateTime date})
      : workoutYear = date.year,
        workoutMonth = date.month,
        workoutDay = date.day;

  Future<List<ExerciseResult>> results(ExerciseResultProvider provider) {
    return provider.getExerciseResultsByWorkoutId(id!);
  }

  DateTime get date => DateTime(workoutYear, workoutMonth, workoutDay);

  @override
  String toString() {
    // return 'Workout: $date\n${results.join('\n')}';
    return '';
  }
}

extension MonthDayYearFormat on DateTime {
  String formatMonthDayYear() {
    return '$month/$day/$year';
  }
}
