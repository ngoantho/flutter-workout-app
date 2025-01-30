import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/exercise.dart';

class ExerciseResultController {
  Exercise exercise;
  TextEditingController actualOutputController;

  ExerciseResultController({required this.exercise, required this.actualOutputController});
}