import 'package:floor/floor.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/typedefs/output.dart';

@Entity(tableName: 'exercise', foreignKeys: [
  ForeignKey(
      childColumns: ["workout_plan_id"],
      parentColumns: ['id'],
      entity: WorkoutPlan)
])
class Exercise {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'workout_plan_id')
  int? workoutPlanId;

  String name;
  Output target;
  MeasurementUnit unit;

  Exercise(
      {this.id,
      this.workoutPlanId,
      required this.name,
      required this.target,
      required this.unit});

  Exercise.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        target = json['target'],
        unit = MeasurementUnit.fromString(json['unit']),
        workoutPlanId = json['workout_plan_id'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'target': target,
      'unit': unit.index,
      'workout_plan_id': workoutPlanId
    };
  }

  @override
  String toString() {
    return '$name, target: $target, unit: $unit';
  }
}
