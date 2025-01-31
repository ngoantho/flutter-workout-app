import 'dart:async';

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
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (stopwatch.isRunning) {
        setState(() {
          widget.actualOutputController.output = stopwatch.elapsed.inSeconds;
          debugPrint('running: ${widget.actualOutputController.output}');
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: TextFormField(
        controller: widget.actualOutputController,
        // focusNode: DisabledFocusNode(),
        decoration: InputDecoration(
          suffixText: 'seconds',
          suffixIcon: IconButton(onPressed: widget.actualOutputController.clear, icon: Icon(Icons.backspace))
        )
      )),
      SizedBox(
        width: 100, 
        child: ElevatedButton(onPressed: stopwatch.isRunning ? null : startStopwatch, child: Text('Start'))
      ),
      SizedBox(width: 10,),
      SizedBox(
        width: 100, 
        child: ElevatedButton(onPressed: stopwatch.isRunning ? stopStopwatch : null, child: Text('Stop'))
      )
    ],);
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