import 'package:flutter/material.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/output.dart';

class WorkoutPlan {
  String name;
  List<Exercise> exercises;

  WorkoutPlan({required this.name, required this.exercises});

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = List.from(json['exercises']).map(
      (e) {
        final exercise = Exercise(
          name: e['name'],
          target: Output(e['target']),
          unit: MeasurementUnit.fromString(e['unit']),
        );
        debugPrint(exercise.toString());
        return exercise;
      },
    ).toList();
    return WorkoutPlan(name: json['name'], exercises: exercises);
  }
}
