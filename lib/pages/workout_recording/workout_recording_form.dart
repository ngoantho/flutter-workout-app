import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/enums/workout_type.dart';
import 'package:homework/firebase/firebase_workouts.dart';
import 'package:homework/mixins/flat_button.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_card.dart';
import 'package:homework/solo_local_db/exercises.dart';
import 'package:homework/solo_local_db/solo_exercise_results.dart';
import 'package:homework/solo_local_db/solo_workouts.dart';
import 'package:homework/typedefs/output.dart';
import 'package:homework/utils/common_appbar.dart';
import 'package:homework/utils/common_navbar.dart';
import 'package:homework/utils/readonly_textfield.dart';
import 'package:provider/provider.dart';

import '../../firebase/firebase_results.dart';

class WorkoutRecordingForm extends StatefulWidget {
  final WorkoutPlan workoutPlan;
  final List<ExerciseResultController>? controllers;
  final WorkoutType workoutType;

  const WorkoutRecordingForm(this.workoutPlan, this.workoutType,
      {super.key, this.controllers});

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
  final workoutId = Random.secure().nextInt(100000);

  void onSave(List<ExerciseResultController> controllers) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final workout = Workout.fromDate(
        date: DateTime(
          yearController.text.toOutput(),
          monthController.text.toOutput(),
          dayController.text.toOutput(),
        ),
        type: widget.workoutType,
        id: workoutId);

    // fix for accessing context in switch
    final soloWorkoutProvider = context.read<SoloWorkouts>();
    final firebaseWorkoutProvider = context.read<FirebaseWorkouts>();
    final firebaseResultsProvider = context.read<FirebaseResults>();

    switch (widget.workoutType) {
      case WorkoutType.solo:
        await soloWorkoutProvider.addWorkout(workout);
        break;
      case WorkoutType.collaborative:
        await firebaseWorkoutProvider.addWorkout(workout);
        break;
      case WorkoutType.competitive:
        await firebaseWorkoutProvider.addWorkout(workout);
        break;
    }

    for (var controller in controllers) {
      final exerciseResult = ExerciseResult(
          targetOutput: controller.exercise.target,
          exerciseName: controller.exercise.name,
          measurementUnit: controller.exercise.unit,
          actualOutput: controller.actualOutput,
          workoutId: workoutId);
      if (mounted) {
        switch (widget.workoutType) {
          case WorkoutType.solo:
            await context.read<SoloExerciseResults>().add(exerciseResult);
            break;
          case WorkoutType.collaborative:
            await firebaseResultsProvider.add(exerciseResult);
            break;
          case WorkoutType.competitive:
            await firebaseResultsProvider.add(exerciseResult);
            break;
        }
      }
    }

    if (mounted) {
      switch (widget.workoutType) {
        case WorkoutType.solo:
          Navigator.of(context).pushNamed('/solo');
          break;
        case WorkoutType.collaborative:
          Navigator.of(context).pushNamed('/collaborative');
          break;
        case WorkoutType.competitive:
          Navigator.of(context).pushNamed('/competitive');
          break;
      }
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
          title: Text('Plan: ${widget.workoutPlan.name}'),
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
          await widget.workoutPlan.exercises(context.read<Exercises>());
      return exercises
          .map((exercise) => ExerciseResultController(
              exercise: exercise, controller: TextEditingController()))
          .toList();
    }

    Widget shareWorkout() {
      onPressed() {
        String encodedWorkout = base64Encode(utf8.encode(jsonEncode({
          'workoutPlan': widget.workoutPlan.toJson(),
          'workout': workoutId
        })));

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: ReadonlyTextField(
                  labelText: 'Copy This',
                  value: encodedWorkout,
                  enabled: true,
                ),
                actions: [
                  FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close'))
                ],
              );
            });
      }

      return FilledButton(onPressed: onPressed, child: Text('Share Workout'));
    }

    Widget builder(
        context, AsyncSnapshot<List<ExerciseResultController>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final controllers = snapshot.data!;
      return Scaffold(
        appBar: CommonAppBar(
          'Record',
          additionalActions: [
            if (widget.workoutType == collaborative ||
                widget.workoutType == competitive)
              shareWorkout()
          ],
        ),
        body: Form(key: _formKey, child: formContent(controllers)),
        bottomNavigationBar: CommonNavbar(
          top: bottomWidget(controllers),
        ),
      );
    }

    return FutureBuilder(future: future(), builder: builder);
  }
}
