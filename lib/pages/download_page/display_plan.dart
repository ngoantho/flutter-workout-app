import 'package:flutter/material.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class DisplayPlanPage extends StatelessWidget with NavigateMixin {
  final WorkoutPlan workoutPlan;
  final List<Exercise> exercises;

  const DisplayPlanPage(this.workoutPlan, this.exercises, {super.key});

  @override
  Widget build(BuildContext context) {
    // final workoutPlan = WorkoutPlan.fromJson(json);
    //     int workoutPlanId =
    //         await context.read<WorkoutPlanDao>().addWorkoutPlan(workoutPlan);

    //     for (var e in List.from(json['exercises'])) {
    //       final exercise = Exercise.fromJson(e);
    //       exercise.workoutPlanId = workoutPlanId;
    //       if (mounted) {
    //         await context.read<ExerciseDao>().addExercise(exercise);
    //       }
    //     }

    saveWorkoutPlan() async {
      final workoutPlanId =
          await context.read<WorkoutPlanDao>().addWorkoutPlan(workoutPlan);

      for (var e in exercises) {
        e.workoutPlanId = workoutPlanId;
        if (context.mounted) {
          await context.read<ExerciseDao>().addExercise(e);
        }
      }
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
