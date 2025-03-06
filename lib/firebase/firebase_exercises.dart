import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/models/exercise.dart';

class FirebaseExercises extends ExerciseDao with ChangeNotifier {
  @override
  Future<int> addExercise(Exercise exercise) async {
    notifyListeners();
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("exercises")
        .add(exercise.toJson());
    return ref.id.hashCode;
  }

  @override
  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId) async {
    final query = await FirebaseFirestore.instance
        .collection("exercises")
        .where("workoutPlanId", isEqualTo: workoutPlanId)
        .get();
    return query.docs.map((doc) => Exercise.fromJson(doc.data())).toList();
  }
}
