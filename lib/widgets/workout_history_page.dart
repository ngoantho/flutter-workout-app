import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/sample_workouts.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:homework/widgets/workout_detail_page.dart';

class WorkoutHistoryPage extends StatelessWidget {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(ListView.separated(
      itemCount: sampleWorkouts.length,
      itemBuilder: (context, index) =>
          _WorkoutHistoryEntry(sampleWorkouts[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 50,
      ),
    ), title: 'Workout History',);
  }
}

class _WorkoutHistoryEntry extends StatelessWidget {
  final Workout workout;

  const _WorkoutHistoryEntry(this.workout);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WorkoutDetailsPage(workout)))
            },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Workout: ${workout.date.toString()}",
            ),
            Text('Exercise Results: ${workout.results.length}'),
            _SuccessfulResults(workout.results)
          ],
        ));
  }
}

class _SuccessfulResults extends StatefulWidget {
  final List<ExerciseResult> results;

  const _SuccessfulResults(this.results);

  @override
  State<_SuccessfulResults> createState() => _SuccessfulResultsState();
}

class _SuccessfulResultsState extends State<_SuccessfulResults> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = 0;
    for (var result in widget.results) {
      if (isSuccessful(
          actual: result.actualOutput, target: result.exercise.targetOutput)) {
        count += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Successful Results: $count',
    );
  }
}
