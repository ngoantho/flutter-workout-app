import 'package:date_only/date_only.dart';
import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/test_page.dart';
import 'package:homework/providers/workout_provider.dart';
import 'package:homework/widgets/centering/center_text.dart';
import 'package:homework/widgets/readonly_textfield.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_card.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutRecordingPage(this.workoutPlan, {super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> with NavigateMixin {
  final _formKey = GlobalKey<FormState>();
  final _today = DateOnly.today();
  bool validated = false;
  late List<ExerciseResultController> _exerciseResultControllers;

  void onSave() {
    final workout = Workout(
        date: _today,
        results: _exerciseResultControllers
            .map((controller) => ExerciseResult(
                exercise: controller.exercise,
                actualOutput: controller.actualOutput))
            .toList());
    context.read<WorkoutProvider>().add(workout);
    navigateBack(context: context);
  }

  @override
  void initState() {
    super.initState();
    _exerciseResultControllers = widget.workoutPlan.exercises
        .map((exercise) => ExerciseResultController(
            exercise: exercise, controller: TextEditingController()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () => {
        setState(
          () => validated = _formKey.currentState!.validate(),
        )
      },
      child: CommonScaffold(
        title: 'Record Workout',
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
                      _exerciseResultControllers[index].controller),
                  itemCount: _exerciseResultControllers.length)),
          FilledButton(
            onPressed: validated ? onSave : null,
            child: CenterText('Save Workout'),
          )
      ])));
  }
}
