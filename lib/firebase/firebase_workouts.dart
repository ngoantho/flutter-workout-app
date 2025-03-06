import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/workout.dart';

class FirebaseWorkouts extends WorkoutDao with ChangeNotifier {
  @override
  Future<int> addWorkout(Workout workout) async {
    notifyListeners();
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("workouts")
        .add(workout.toJson());
    return ref.id.hashCode;
  }

  @override
  Future<List<Workout>> getAllWorkouts() async {
    final query = await FirebaseFirestore.instance.collection("workouts").get();
    return query.docs.map((e) => Workout.fromJson(e.data())).toList();
  }

  Future<List<Workout>> getAllCollaborative() async {
    final query = await FirebaseFirestore.instance
        .collection("workouts")
        .where("workout_type", isEqualTo: "collaborative")
        .get();
    return query.docs.map((e) => Workout.fromJson(e.data())).toList();
  }

  Future<List<Workout>> getAllCompetitive() async {
    final query = await FirebaseFirestore.instance
        .collection("workouts")
        .where("workout_type", isEqualTo: "competitive")
        .get();
    return query.docs.map((e) => Workout.fromJson(e.data())).toList();
  }
}
