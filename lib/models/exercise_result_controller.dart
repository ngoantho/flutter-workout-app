import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/output.dart';

class ExerciseResultController {
  Exercise exercise;
  TextEditingController actualOutputController;

  ExerciseResultController({required this.exercise, required this.actualOutputController});

  ExerciseResult toExerciseResult() {
    return ExerciseResult(exercise: exercise, actualOutput: actualOutputController.text.toOutput());
  }

  Output get actualOutput => actualOutputController.text.toOutput();
}
