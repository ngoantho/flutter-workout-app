import 'package:flutter/material.dart';
import 'package:homework/enums/workout_type.dart';
import 'package:homework/firebase/firebase_workouts.dart';
import 'package:homework/mixins/flat_button.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/download_page/download_plan.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_recording/workout_recording_page.dart';
import 'package:homework/solo_local_db/solo_workouts.dart';
import 'package:homework/utils/common_appbar.dart';
import 'package:homework/utils/common_navbar.dart';
import 'package:provider/provider.dart';

class WorkoutHistoryPage extends StatelessWidget
    with NavigateMixin, FlatButtonStyle {
  final WorkoutType workoutType;

  const WorkoutHistoryPage(this.workoutType, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: switch (workoutType) {
        WorkoutType.solo => context.watch<SoloWorkouts>().getAllWorkouts(),
        WorkoutType.collaborative =>
          context.watch<FirebaseWorkouts>().getAllCollaborative(),
        WorkoutType.competitive =>
          context.watch<FirebaseWorkouts>().getAllCompetitive(),
      },
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Workout>? workouts = snapshot.data;
        return Scaffold(
          appBar: CommonAppBar('Workout History'),
          bottomNavigationBar: CommonNavbar(
            top: navMenu(context),
          ),
          body: (workouts != null) ? listContent(workouts) : null,
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
          onPressed: () =>
              navigate(context).to(WorkoutRecordingPage(workoutType)),
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
