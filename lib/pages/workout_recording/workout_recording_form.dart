import 'package:flutter/material.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/mixins/flat_button.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/typedefs/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/readonly_textfield.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_card.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutRecordingForm extends StatefulWidget {
  final WorkoutPlan workoutPlan;
  final List<ExerciseResultController>? controllers;

  const WorkoutRecordingForm(this.workoutPlan, {this.controllers, super.key});

  @override
  State<WorkoutRecordingForm> createState() => _WorkoutRecordingFormState();
}

class _WorkoutRecordingFormState extends State<WorkoutRecordingForm>
    with NavigateMixin, ValidateOutputMixin, FlatButtonStyle {
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
      workoutYear: yearController.text.toOutput(),
      workoutMonth: monthController.text.toOutput(),
      workoutDay: dayController.text.toOutput(),
    );
    final results = controllers.map((controller) => ExerciseResult(
        targetOutput: controller.exercise.target,
        exerciseName: controller.exercise.name,
        measurementUnit: controller.exercise.unit,
        actualOutput: controller.actualOutput));
    // context.read<WorkoutsProvider>().add(workout);
    navigate(context).back();
  }

  @override
  void initState() async {
    super.initState();

    if (widget.controllers != null) {
      controllers = widget.controllers!;
    } else {
      final exercises =
          await widget.workoutPlan.exercises(context.read<ExerciseDao>());

      controllers = exercises
          .map((exercise) => ExerciseResultController(
              exercise: exercise, controller: TextEditingController()))
          .toList();
    }

    yearController.text = _today.year.toString();
    monthController.text = _today.month.toString();
    dayController.text = _today.day.toString();
  }

  Column get formContent {
    return Column(children: [
      ListTile(
          title: ReadonlyTextField(
              labelText: 'Workout Plan', value: widget.workoutPlan.name),
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
                  controllers[index].exercise, controllers[index].controller),
              itemCount: controllers.length)),
    ]);
  }

  Widget get bottomWidget {
    return FilledButton(
      onPressed: onSave,
      key: Key('validateFormBtnKey'),
      style: flatButtonStyle,
      child: Text('Save Workout'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: formContent);
  }
}
