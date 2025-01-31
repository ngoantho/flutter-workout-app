import 'package:flutter/material.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/pages/workout_recording/methods/minus_value_plus_method.dart';
import 'package:homework/pages/workout_recording/methods/value_dropdown_method.dart';
import 'package:homework/pages/workout_recording/methods/value_slider_method.dart';
import 'package:homework/widgets/readonly_textfield.dart';
import 'package:homework/models/exercise.dart';

class WorkoutRecordingCard extends StatefulWidget {
  final Exercise exercise;
  final TextEditingController controller;

  const WorkoutRecordingCard(this.exercise, this.controller,
      {super.key});

  @override
  State<WorkoutRecordingCard> createState() => _WorkoutRecordingCardState();
}

class _WorkoutRecordingCardState extends State<WorkoutRecordingCard> {
  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: ListTile(
          title: Row(
            children: [
              Expanded(
                  child: ReadonlyTextField(
                      labelText: 'Exercise', value: widget.exercise.name)),
              SizedBox(
                  width: 75,
                  child: ReadonlyTextField(
                      labelText: 'Target',
                      value: widget.exercise.targetOutput.toString())),
              SizedBox(
                  width: 100,
                  child: ReadonlyTextField(
                      labelText: 'Unit',
                      value: widget.exercise.measurementUnit.name))
            ],
          ),
          subtitle: switch (widget.exercise.measurementUnit) {
            MeasurementUnit.seconds => ValueSliderMethod(
                widget.controller), // value slider +/-
            MeasurementUnit.meters => ValueDropdownMethod(
                widget.controller), // value dropdown +/-
            MeasurementUnit.repetitions =>
              MinusValuePlusMethod(widget.controller) // - value +
          }),
    );
  }
}
