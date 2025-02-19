import 'package:flutter/material.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/mixins/flat_button.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/download_page/download_plan.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_recording/workout_recording_page.dart';
import 'package:homework/utils/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutHistoryPage extends StatelessWidget
    with NavigateMixin, FlatButtonStyle {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<WorkoutProvider>().getAllWorkouts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Workout> workouts = snapshot.data!;
        return CommonScaffold(
          title: 'Workout History',
          bottomWidget: navMenu(context),
          content: listContent(workouts),
        );
      },
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
          onPressed: () => navigate(context).to(WorkoutRecordingPage()),
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
