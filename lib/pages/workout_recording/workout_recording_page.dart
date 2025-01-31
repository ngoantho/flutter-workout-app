import 'package:date_only/date_only.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/readonly_textfield.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_card.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutRecordingPage(this.workoutPlan, {super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  final _formKey = GlobalKey<FormState>();
  final _today = DateOnly.today();
  late List<ExerciseResultController> _exerciseResultControllers;

  void onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final _ = Workout(
        date: _today,
        results: _exerciseResultControllers
            .map((controller) => ExerciseResult(
                exercise: controller.exercise,
                actualOutput: controller.actualOutput))
            .toList());
  }

  @override
  void initState() {
    super.initState();
    _exerciseResultControllers = widget.workoutPlan.exercises
        .map((exercise) => ExerciseResultController(
            exercise: exercise,
            controller: TextEditingController()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: CommonScaffold(
            title: 'Record Workout',
            floatingActionButton:
                IconButton.filled(onPressed: onSave, icon: Icon(Icons.save)),
            content: Column(children: [
              ListTile(
                title: ReadonlyTextField(
                    labelText: 'Workout Plan', value: widget.workoutPlan.name),
                subtitle: ReadonlyTextField(
                    labelText: 'Workout Date', value: _today.toString()),
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => WorkoutRecordingCard(
                          _exerciseResultControllers[index].exercise,
                          _exerciseResultControllers[index]
                              .controller),
                      itemCount: _exerciseResultControllers.length))
            ])));
  }
}
