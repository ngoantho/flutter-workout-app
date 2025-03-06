import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/workout_plan.dart';

import '../dao/workout_plans.dart';

class FirebasePlans extends WorkoutPlanDao with ChangeNotifier {
  @override
  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan) async {
    notifyListeners();
    final ref = await FirebaseFirestore.instance
        .collection("workoutPlans")
        .add(workoutPlan.toJson());
    return int.parse(ref.id);
  }

  @override
  Future<List<WorkoutPlan>> getAllWorkoutPlans() async {
    final query =
        await FirebaseFirestore.instance.collection("workoutPlans").get();
    return query.docs.map((e) => WorkoutPlan.fromJson(e.data())).toList();
  }

  @override
  Future<int?> getWorkoutPlanByURL(String url) async {
    final query = await FirebaseFirestore.instance
        .collection("workoutPlans")
        .where("url", isEqualTo: url)
        .get();
    return query.docs.isEmpty ? null : int.parse(query.docs.first.id);
  }
}
