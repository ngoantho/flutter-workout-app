import 'package:flutter/material.dart';
import 'package:homework/examples/sample_workout_plan.dart';
import 'package:homework/mixins/flat_button.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/download_page/download_plan.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_recording/workout_recording_page.dart';
import 'package:homework/providers/workouts_provider.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutHistoryPage extends StatelessWidget
    with NavigateMixin, FlatButtonStyle {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = context.watch<WorkoutsProvider>().workouts;

    return CommonScaffold(
      title: 'Workout History',
      bottomWidget: navMenu(context),
      content: listContent(workouts),
    );
  }

  Row navMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: () => navigate(context).to(DownloadPlanPage()),
          label: Text("Download Plan"),
          icon: Icon(Icons.download),
        ),
        OutlinedButton.icon(
          onPressed: () =>
              navigate(context).to(WorkoutRecordingPage(sampleWorkoutPlan)),
          label: Text("Record Workout"),
          icon: Icon(Icons.run_circle_outlined),
        )
      ],
    );
  }

  Column listContent(List<Workout> workouts) {
    return Column(
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
      ],
    );
  }
}
