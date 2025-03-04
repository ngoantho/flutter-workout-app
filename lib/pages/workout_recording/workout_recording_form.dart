import 'package:flutter/material.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/providers/exercise_results.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/mixins/flat_button.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_card.dart';
import 'package:homework/typedefs/output.dart';
import 'package:homework/utils/common_scaffold.dart';
import 'package:homework/utils/readonly_textfield.dart';
import 'package:provider/provider.dart';

class WorkoutRecordingForm extends StatefulWidget {
  final WorkoutPlan workoutPlan;
  final List<ExerciseResultController>? controllers;

  const WorkoutRecordingForm(this.workoutPlan, {super.key, this.controllers});

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

  void onSave(List<ExerciseResultController> controllers) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final workout = Workout.fromDate(
        date: DateTime(
      yearController.text.toOutput(),
      monthController.text.toOutput(),
      dayController.text.toOutput(),
    ));
    int workoutId = await context.read<WorkoutProvider>().addWorkout(workout);

    for (var controller in controllers) {
      final exerciseResult = ExerciseResult(
          targetOutput: controller.exercise.target,
          exerciseName: controller.exercise.name,
          measurementUnit: controller.exercise.unit,
          actualOutput: controller.actualOutput,
          workoutId: workoutId);
      if (mounted) {
        await context
            .read<ExerciseResults>()
            .add(exerciseResult);
      }
    }

    if (mounted) {
      navigate(context).home();
    }
  }

  @override
  void initState() {
    super.initState();

    yearController.text = _today.year.toString();
    monthController.text = _today.month.toString();
    dayController.text = _today.day.toString();
  }

  Column formContent(List<ExerciseResultController> controllers) {
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

  Widget bottomWidget(List<ExerciseResultController> controllers) {
    return FilledButton(
      onPressed: () => onSave(controllers),
      key: Key('validateFormBtnKey'),
      style: flatButtonStyle,
      child: Text('Save Workout'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ExerciseResultController>> future() async {
      if (widget.controllers != null) {
        return (widget.controllers!).toList();
      }

      final exercises =
          await widget.workoutPlan.exercises(context.read<ExerciseProvider>());
      return exercises
          .map((exercise) => ExerciseResultController(
              exercise: exercise, controller: TextEditingController()))
          .toList();
    }

    Widget builder(
        context, AsyncSnapshot<List<ExerciseResultController>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final controllers = snapshot.data!;
      return CommonScaffold(
        title: 'Record Workout',
        subtitle: 'Enter Output',
        content: Form(key: _formKey, child: formContent(controllers)),
        bottomWidget: bottomWidget(controllers),
      );
    }

    return FutureBuilder(future: future(), builder: builder);
  }
}
