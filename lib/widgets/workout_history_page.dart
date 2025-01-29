import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/mixins/common_scaffold.dart';
import 'package:homework/widgets/workout_detail_page.dart';

class WorkoutHistoryPage extends StatelessWidget with CommonScaffold {
  final List<Workout> workouts;

  const WorkoutHistoryPage(this.workouts, {super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold(
        title: 'Workout History',
        content: ListView.separated(
          itemCount: workouts.length,
          itemBuilder: (context, index) =>
              _WorkoutHistoryEntry(workouts[index]),
          separatorBuilder: (context, index) => SizedBox(
            height: 50,
          ),
        ));
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
              "Workout: ${workout.dateToString()}",
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
      if (Output.isSuccessful(
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
