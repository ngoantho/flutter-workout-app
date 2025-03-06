import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/solo_local_db/solo_exercises.dart';
import 'package:homework/solo_local_db/workout_plans.dart';
import 'package:homework/utils/common_appbar.dart';
import 'package:homework/utils/common_navbar.dart';
import 'package:provider/provider.dart';

class DisplayPlanPage extends StatelessWidget with NavigateMixin {
  final WorkoutPlan workoutPlan;
  final List<Exercise> exercises;

  const DisplayPlanPage(this.workoutPlan, this.exercises, {super.key});

  @override
  Widget build(BuildContext context) {
    final workoutPlanDao = context.read<WorkoutPlans>();
    final exerciseDao = context.read<Exercises>();
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
          await workoutPlanDao.getWorkoutPlanByURL(workoutPlan.url);
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

    return Scaffold(
      appBar: CommonAppBar(workoutPlan.name),
      body: ListView.builder(
        itemBuilder: (context, index) => _PlanEntry(exercises[index]),
        itemCount: exercises.length,
      ),
      bottomNavigationBar: CommonNavbar(
          top: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton.icon(
            onPressed: () => navigate(context).back(null),
            label: Text('Discard'),
            icon: Icon(Icons.delete),
          ),
          FilledButton.icon(
            onPressed: saveWorkoutPlan,
            label: Text('Save'),
            icon: Icon(Icons.save),
          )
        ],
      )),
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
