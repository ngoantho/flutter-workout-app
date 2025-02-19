import 'package:flutter/material.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/utils/common_scaffold.dart';
import 'package:provider/provider.dart';

class DisplayPlanPage extends StatelessWidget with NavigateMixin {
  final WorkoutPlan workoutPlan;
  final List<Exercise> exercises;

  const DisplayPlanPage(this.workoutPlan, this.exercises, {super.key});

  @override
  Widget build(BuildContext context) {
    final workoutPlanDao = context.read<WorkoutPlanProvider>();
    final exerciseDao = context.read<ExerciseProvider>();
    final messenger = ScaffoldMessenger.of(context);

    showMessage(String message) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 1),
        ),
      );
    }

    saveWorkoutPlan() async {
      int? workoutPlanId =
          await workoutPlanDao.getWorkoutPlanByName(workoutPlan.name);
      if (workoutPlanId != null) {
        debugPrint("workout plan already exists");
        showMessage("'${workoutPlan.name}' already exists");
        return;
      }

      workoutPlanId = await workoutPlanDao.addWorkoutPlan(workoutPlan);
      for (var e in exercises) {
        e.workoutPlanId = workoutPlanId;
        await exerciseDao.addExercise(e);
      }

      showMessage("'${workoutPlan.name}' added");
    }

    return CommonScaffold(
      title: workoutPlan.name,
      content: ListView.builder(
        itemBuilder: (context, index) => _PlanEntry(exercises[index]),
        itemCount: exercises.length,
      ),
      bottomWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton.icon(
            onPressed: () => navigate(context).back(),
            label: Text('Discard'),
            icon: Icon(Icons.delete),
          ),
          OutlinedButton.icon(
            onPressed: saveWorkoutPlan,
            label: Text('Save'),
            icon: Icon(Icons.save),
          )
        ],
      ),
    );
  }
}

class _PlanEntry extends StatelessWidget {
  final Exercise exercise;

  const _PlanEntry(this.exercise);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          exercise.name,
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          "Target: ${exercise.target} ${exercise.unit}",
          textAlign: TextAlign.center,
        ));
  }
}
