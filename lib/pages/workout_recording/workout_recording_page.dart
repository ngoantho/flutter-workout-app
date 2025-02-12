import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/providers/workouts_provider.dart';
import 'package:homework/widgets/readonly_textfield.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_card.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;
  final List<ExerciseResultController>? controllers;

  const WorkoutRecordingPage(this.workoutPlan, {this.controllers, super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage>
    with NavigateMixin, ValidateOutputMixin {
  final _formKey = GlobalKey<FormState>();
  final _today = DateTime.now();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();
  late List<ExerciseResultController> controllers;

  void onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final workout = Workout(
        date: DateTime(
            yearController.text.toOutput().value,
            monthController.text.toOutput().value,
            dayController.text.toOutput().value),
        results: controllers
            .map((controller) => ExerciseResult(
                exercise: controller.exercise,
                actualOutput: controller.actualOutput))
            .toList());
    context.read<WorkoutsProvider>().add(workout);
    navigateBack(context: context);
  }

  @override
  void initState() {
    super.initState();

    controllers = widget.controllers ??
        widget.workoutPlan.exercises
            .map((exercise) => ExerciseResultController(
                exercise: exercise, controller: TextEditingController()))
            .toList();

    yearController.text = _today.year.toString();
    monthController.text = _today.month.toString();
    dayController.text = _today.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: CommonScaffold(
            title: 'Record Workout',
            bottomWidget: FilledButton(
              onPressed: onSave,
              key: Key('validateFormBtnKey'),
              child: Text('Save Workout'),
            ),
            content: Column(children: [
              ListTile(
                  title: ReadonlyTextField(
                      labelText: 'Workout Plan',
                      value: widget.workoutPlan.name),
                  subtitle: Row(
                    children: [
                      Flexible(
                          child: TextFormField(
                        controller: yearController,
                        decoration: InputDecoration(labelText: 'year'),
                        keyboardType: TextInputType.number,
                        validator: validateOutput,
                      )),
                      Flexible(
                          child: TextFormField(
                        controller: monthController,
                        decoration: InputDecoration(labelText: 'month'),
                        keyboardType: TextInputType.number,
                        validator: validateOutput,
                      )),
                      Flexible(
                          child: TextFormField(
                        controller: dayController,
                        decoration: InputDecoration(labelText: 'day'),
                        keyboardType: TextInputType.number,
                        validator: validateOutput,
                      ))
                    ],
                  )),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => WorkoutRecordingCard(
                          controllers[index].exercise,
                          controllers[index].controller),
                      itemCount: controllers.length)),
            ])));
  }
}
