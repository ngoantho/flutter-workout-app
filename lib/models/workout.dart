import 'package:floor/floor.dart';
import 'package:homework/enums/workout_type.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/solo_local_db/solo_exercise_results.dart';

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

  WorkoutType workoutType;

  Workout(
      {this.id,
      required this.workoutDay,
      required this.workoutMonth,
      required this.workoutYear,
      required this.workoutType});

  Workout.fromDate({this.id, required DateTime date, required WorkoutType type})
      : workoutYear = date.year,
        workoutMonth = date.month,
        workoutDay = date.day,
        workoutType = type;

  Workout.fromJson(Map<String, dynamic> json)
      : workoutDay = json['workout_day'],
        workoutMonth = json['workout_month'],
        workoutYear = json['workout_year'],
        workoutType = WorkoutType.fromString(json['workout_type']);

  Map<String, dynamic> toJson() {
    return {
      'workout_day': workoutDay,
      'workout_month': workoutMonth,
      'workout_year': workoutYear,
      'workout_type': workoutType
    };
  }

  Future<List<ExerciseResult>> results(SoloExerciseResults provider) {
    return provider.getAllByWorkoutId(id!);
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
