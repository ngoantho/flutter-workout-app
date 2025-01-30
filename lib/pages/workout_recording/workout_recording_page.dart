import 'package:date_only/date_only.dart';
import 'package:flutter/material.dart';
import 'package:homework/mixins/readonly_textfield.dart';
import 'package:homework/models/exercise_result_controller.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutRecordingPage(this.workoutPlan, {super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> with ReadonlyTextFieldMixin {
  final _formKey = GlobalKey<FormState>();
  final _workoutDate = DateOnly.today();
  late List<ExerciseResultController> _exerciseResultControllers;

  void onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    for (var composite in _exerciseResultControllers) {
      debugPrint(
          'Exercise: ${composite.exercise.name}, output: ${composite.actualOutput.toString()}');
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
                title: readOnlyTextField(labelText: 'Workout Plan', value: widget.workoutPlan.name),
                subtitle: readOnlyTextField(labelText: 'Workout Date', value: _workoutDate.toString()),
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => WorkoutRecording(
                          _exerciseResultControllers[index].exercise,
                          _exerciseResultControllers[index]
                              .actualOutputController),
                      itemCount: _exerciseResultControllers.length))
            ])));
  }
}
