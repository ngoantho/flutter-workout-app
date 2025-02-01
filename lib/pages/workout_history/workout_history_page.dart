import 'package:flutter/material.dart';
import 'package:homework/examples/sample_workout_plan.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_recording/workout_recording_page.dart';
import 'package:homework/providers/workouts_provider.dart';
import 'package:homework/widgets/centering/center_text.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutHistoryPage extends StatelessWidget with NavigateMixin {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = context.watch<WorkoutsProvider>().workouts;

    return CommonScaffold(
        title: 'Workout History',
        content: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: workouts.length,
                itemBuilder: (context, index) =>
                    WorkoutHistoryEntry(workouts[index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: 50,
                ),
              ),
            ),
            FilledButton(
                onPressed: () => {
                      navigateTo(
                          context: context,
                          widget: WorkoutRecordingPage(sampleWorkoutPlan))
                    },
                child: CenterText('New Workout'))
          ],
        ));
  }
}
