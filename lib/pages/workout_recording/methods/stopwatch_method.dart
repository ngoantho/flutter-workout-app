import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';
import 'package:homework/models/output.dart';

class StopwatchMethod extends StatefulWidget {
  final TextEditingController actualOutputController;

  const StopwatchMethod({super.key, required this.actualOutputController});

  @override
  State<StopwatchMethod> createState() => _StopwatchMethodState();
}

class _StopwatchMethodState extends State<StopwatchMethod> {
  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    stopwatch = Stopwatch();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (stopwatch.isRunning) {
        setState(() {
          widget.actualOutputController.output = stopwatch.elapsed.inSeconds;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
                controller: widget.actualOutputController,
                focusNode: DisabledFocusNode(),
                decoration: widget.actualOutputController.text != ''
                    ? InputDecoration(
                        suffixText: 'seconds',
                        suffixIcon: IconButton(
                            onPressed: resetStopwatch,
                            icon: Icon(Icons.backspace)))
                    : null)),
        SizedBox(
            width: 85,
            child: ElevatedButton(
                onPressed: stopwatch.isRunning ? null : startStopwatch,
                child: Text('Start'))),
        SizedBox(
          width: 10,
        ),
        SizedBox(
            width: 85,
            child: ElevatedButton(
                onPressed: stopwatch.isRunning ? stopStopwatch : null,
                child: Text('Stop')))
      ],
    );
  }

  void resetStopwatch() {
    setState(() {
      stopwatch.stop();
      stopwatch.reset();
      widget.actualOutputController.clear();
    });
  }

  void startStopwatch() {
    setState(() {
      stopwatch.start();
    });
  }

  void stopStopwatch() {
    setState(() {
      stopwatch.stop();
    });
  }
}
