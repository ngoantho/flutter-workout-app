import 'package:date_only/date_only.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result_controller.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/widgets/center_text.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutRecordingPage(this.workoutPlan, {super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  final _formKey = GlobalKey<FormState>();
  final _workoutDate = DateOnly.today();
  late List<ExerciseResultController> _exerciseResultControllers;

  void onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _exerciseResultControllers = widget.workoutPlan.exercises
        .map((exercise) => ExerciseResultController(
            exercise: exercise,
            actualOutputController: TextEditingController()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: CommonScaffold(
            title: 'Record Workout',
            floatingActionButton:
                IconButton.filled(onPressed: onSave, icon: Icon(Icons.save)),
            content: Column(children: [
              ListTile(
                title: CenterText('Workout Plan: ${widget.workoutPlan.name}'),
                subtitle: CenterText('Workout Date: $_workoutDate'),
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => _WorkoutRecording(
                          _exerciseResultControllers[index].exercise,
                          _exerciseResultControllers[index]
                              .actualOutputController),
                      itemCount: _exerciseResultControllers.length))
            ])));
  }
}

class _WorkoutRecording extends StatefulWidget {
  final Exercise exercise;
  final TextEditingController actualOutputController;

  const _WorkoutRecording(this.exercise, this.actualOutputController);

  @override
  State<_WorkoutRecording> createState() => _WorkoutRecordingState();
}

class _WorkoutRecordingState extends State<_WorkoutRecording> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(labelText: 'Exercise'),
              initialValue: widget.exercise.name,
              readOnly: true,
            )),
            SizedBox(
                width: 50,
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Target'),
                    initialValue: widget.exercise.targetOutput.toString(),
                    readOnly: true)),
            SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Unit'),
                  initialValue: widget.exercise.measurementUnit.name,
                  readOnly: true,
                )),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
                child: TextFormField(
                    controller: widget.actualOutputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Actual Output'),
                    validator: validateOutput)),
          ],
        ));
  }

  String? validateOutput(String? input) {
    if (input == null || input.isEmpty) {
      return 'Enter an output ≥ 0';
    } else if (int.parse(input) < 0) {
      return 'Output must be ≥ 0';
    }
    return null;
  }
}
