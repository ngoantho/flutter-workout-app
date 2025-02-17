import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/widgets/common_scaffold.dart';

class DisplayPlanPage extends StatelessWidget with NavigateMixin {
  final WorkoutPlan workoutPlan;

  const DisplayPlanPage(this.workoutPlan, {super.key});

  Widget get dialogContent {
    return Placeholder();
    // TODO get exercises from database
    // return ListView.builder(
    //   itemBuilder: (context, index) => _PlanEntry(workoutPlan.exercises[index]),
    //   itemCount: workoutPlan.exercises.length,
    // );
  }

  Row navMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: () => navigate(context).back(),
          label: Text('Discard'),
          icon: Icon(Icons.delete),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          label: Text('Save'),
          icon: Icon(Icons.save),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: workoutPlan.name,
      content: dialogContent,
      bottomWidget: navMenu(context),
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
