import 'package:flutter/material.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/output.dart';

class ExerciseResultController {
  Exercise exercise;
  TextEditingController actualOutputController;

  ExerciseResultController({required this.exercise, required this.actualOutputController});

  Output get actualOutput => actualOutputController.text.toOutput();
}
