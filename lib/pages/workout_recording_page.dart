import 'package:date_only/date_only.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/widgets/center_column.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:homework/widgets/sized_box_with_height.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutRecordingPage(this.workoutPlan, {super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  final _formKey = GlobalKey<FormState>();
  final _workoutDate = DateOnly.today();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: CommonScaffold(
            title: 'Record Workout',
            content: CenterColumn([
              Text('Workout Plan: ${widget.workoutPlan.name}'),
              Text('Workout Date: $_workoutDate'),
              SizedBoxWithHeight(10),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) =>
                    _WorkoutRecording(widget.workoutPlan.exercises[index]),
                itemCount: widget.workoutPlan.exercises.length,
              ))
            ])));
  }
}

class _WorkoutRecording extends StatefulWidget {
  final Exercise exercise;

  const _WorkoutRecording(this.exercise);

  @override
  State<_WorkoutRecording> createState() => _WorkoutRecordingState();
}

class _WorkoutRecordingState extends State<_WorkoutRecording> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Exercise: ${widget.exercise.name}'),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.exercise.targetOutput.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Target Output'),
              ),
            ),
            Expanded(
                child: TextFormField(
              initialValue: '0',
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Actual Output'),
            ))
          ],
        ),
      ],
    );
  }
}
