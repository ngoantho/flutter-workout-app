import 'package:flutter/material.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/typedefs/output.dart';

class ExerciseResultController {
  Exercise exercise;
  TextEditingController controller;

  ExerciseResultController({required this.exercise, required this.controller});

  Output get actualOutput => controller.text.toOutput();
}
