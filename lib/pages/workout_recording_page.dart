import 'package:date_only/date_only.dart';
import 'package:flutter/material.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/widgets/center_column.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:homework/widgets/sized_box_with_height.dart';

class WorkoutRecordingPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutRecordingPage(this.workoutPlan, {super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  final _formKey = GlobalKey<FormState>();
  final _workoutDate = DateOnly.today();

  void onSave() {}

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: CommonScaffold(
            title: 'Record Workout',
            floatingActionButton:
                IconButton.filled(onPressed: onSave, icon: Icon(Icons.save)),
            content: CenterColumn([
              Text('Workout Plan: ${widget.workoutPlan.name}'),
              Text('Workout Date: $_workoutDate'),
              Divider(),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) =>
                    _WorkoutRecording(widget.workoutPlan.exercises[index]),
                itemCount: widget.workoutPlan.exercises.length,
                separatorBuilder: (context, index) => SizedBoxWithHeight(10),
              ))
            ])));
  }
}

class _WorkoutRecording extends StatefulWidget {
  final Exercise exercise;

  const _WorkoutRecording(this.exercise);

  @override
  State<_WorkoutRecording> createState() => _WorkoutRecordingState();
}

class _WorkoutRecordingState extends State<_WorkoutRecording>
    with DropdownMenuItemsMixin {
  final actualOutputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(labelText: 'Exercise'),
        focusNode: FocusNode(canRequestFocus: false),
        controller: TextEditingController(text: widget.exercise.name),
      ),
      isThreeLine: true,
      subtitle: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                    decoration: InputDecoration(labelText: 'Target Output'),
                    onTap: null,
                    controller: TextEditingController(
                        text: widget.exercise.targetOutput.toString())),
              ),
              Expanded(
                  child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Measurement Unit'),
                      onTap: null,
                      controller: TextEditingController(
                          text: widget.exercise.measurementUnit.name)))
            ],
          )
        ],
      ),
    );

    var test = Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: actualOutputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Actual Output'),
            )),
          ],
        ),
      ],
    );
  }
}
