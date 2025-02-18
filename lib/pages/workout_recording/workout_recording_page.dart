import 'package:flutter/material.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/workout_recording_form.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class WorkoutRecordingPage extends StatefulWidget {
  const WorkoutRecordingPage({super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage>
    with DropdownMenuMixin<WorkoutPlan> {
  WorkoutPlan? selectedPlan;

  PreferredSize dropdownMenu(List<WorkoutPlan> plans) {
    onChange(WorkoutPlan? val) {
      setState(() {
        selectedPlan = val;
      });
    }

    debugPrint("workout plans: ${plans.length}");

    return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DropdownButtonFormField(
          value: selectedPlan,
          items: toDropdownMenuItemList(plans),
          onChanged: onChange,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // final recordingForm = WorkoutRecordingForm(workoutPlan);

    return FutureBuilder<List<WorkoutPlan>>(
      future: context.read<WorkoutPlanDao>().getAllWorkoutPlans(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final plans = snapshot.data!;
        return CommonScaffold(
          title: 'Record Workout',
          topWidget: dropdownMenu(plans),
        );
      },
    );
  }
}
