import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/sample_workouts.dart';
import 'package:homework/widgets/common_page.dart';
import 'package:homework/widgets/workout_detail_page.dart';

class WorkoutHistoryPage extends CommonPage {
  const WorkoutHistoryPage({super.key});

  @override
  Widget content(BuildContext context) {
    return ListView.separated(
      itemCount: sampleWorkouts.length,
      itemBuilder: (context, index) =>
          _WorkoutHistoryEntry(sampleWorkouts[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 50,
      ),
    );
  }

  @override
  String get title => 'Workout History';
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
  int count = 0;

  @override
  void initState() {
    super.initState();
    for (var result in widget.results) {
      if (outputIsSuccessful(
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
