import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/models/exercise_result.dart';

class FirebaseResults extends ExerciseResultDao with ChangeNotifier {
  @override
  Future<int> add(ExerciseResult exerciseResult) async {
    notifyListeners();
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("results")
        .add(exerciseResult.toJson());
    return int.parse(ref.id);
  }

  @override
  Future<List<ExerciseResult>> getAll() async {
    final query = await FirebaseFirestore.instance.collection("results").get();
    return query.docs.map((e) => ExerciseResult.fromJson(e.data())).toList();
  }

  @override
  Future<List<ExerciseResult>> getAllByWorkoutId(int workoutId) async {
    final query = await FirebaseFirestore.instance
        .collection("results")
        .where('workout_id', isEqualTo: workoutId)
        .get();
    return query.docs.map((e) => ExerciseResult.fromJson(e.data())).toList();
  }
}
