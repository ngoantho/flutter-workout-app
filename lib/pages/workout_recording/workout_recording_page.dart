import 'package:flutter/material.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_form.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutRecordingPage extends StatefulWidget {
  const WorkoutRecordingPage({super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage>
    with DropdownMenuMixin<WorkoutPlan>, NavigateMixin {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkoutPlan>>(
      future: WorkoutPlanDao.from(context).getAllWorkoutPlans(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final plans = snapshot.data!;
        return CommonScaffold(
          title: 'Record Workout',
          subtitle: 'Choose Plan',
          content: radioMenu(plans),
          bottomWidget: submitButton(plans),
        );
      },
    );
  }

  FilledButton submitButton(List<WorkoutPlan> plans) {
    onPressed() {
      final recordingForm = WorkoutRecordingForm(plans[selectedIndex!]);
      navigate(context).to(recordingForm);
    }

    return FilledButton.icon(
        onPressed: (selectedIndex != null) ? onPressed : null,
        icon: Icon(Icons.arrow_forward),
        label: Text("Next"));
  }

  NavigationRail radioMenu(List<WorkoutPlan> plans) {
    return NavigationRail(
        destinations: plans
            .map(
              (plan) => NavigationRailDestination(
                  icon: Icon(Icons.radio_button_unchecked),
                  selectedIcon: Icon(Icons.radio_button_checked),
                  label: Text(plan.name)),
            )
            .toList(),
        extended: true,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex);
  }
}
