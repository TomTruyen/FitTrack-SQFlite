import 'package:fittrack/models/exercises/ExerciseSet.dart';
import 'package:fittrack/models/workout/Workout.dart';
import 'package:flutter/material.dart';

import 'package:fittrack/models/exercises/Exercise.dart';

class WorkoutChangeNotifier extends ChangeNotifier {
  int id;
  String name;
  String weightUnit;
  int timeInMillisSinceEpoch;
  List<Exercise> exercises = [];

  String duration;
  int workoutDurationInMilliseconds;
  String note;

  // Used when calling a 'replace exercise'
  Exercise exerciseToReplace;
  int exerciseToReplaceIndex;

  WorkoutChangeNotifier({
    this.id,
    this.name = "",
    this.weightUnit = "kg",
    this.timeInMillisSinceEpoch,
    this.exercises = const [],
    this.duration = "00:00",
    this.workoutDurationInMilliseconds = 0,
    this.note = "",
  });

  void copyWorkout(Workout workout) {
    id = workout.id;
    name = workout.name ?? "";
    weightUnit = workout.weightUnit ?? "kg";
    timeInMillisSinceEpoch =
        workout.timeInMillisSinceEpoch ?? DateTime.now().millisecondsSinceEpoch;
    exercises = List.of(workout.exercises) ?? [];
    duration = workout.duration ?? "00:00";
    workoutDurationInMilliseconds = workout.workoutDurationInMilliseconds ?? 0;
    note = workout.note ?? "";
  }

  void reset() {
    id = null;
    name = "";
    weightUnit = "kg";
    timeInMillisSinceEpoch = null;
    exercises = [];
    duration = "00:00";
    workoutDurationInMilliseconds = 0;
    note = "";
  }

  void updateName(String _name) {
    name = _name;
  }

  void updateExercises(List<Exercise> _exercises) {
    exercises = _exercises;

    notifyListeners();
  }

  void replaceExercise(Exercise _exercise) {
    exercises[exerciseToReplaceIndex] = _exercise.clone();

    notifyListeners();
  }

  void removeExercise(int exerciseIndex) {
    exercises.removeAt(exerciseIndex);

    notifyListeners();
  }

  void moveExercise(int oldIndex, int newIndex) {
    Exercise _exercise = exercises.removeAt(oldIndex);

    exercises.insert(newIndex, _exercise);

    notifyListeners();
  }

  void toggleNotes(int exerciseIndex) {
    if (exercises[exerciseIndex].hasNotes == 0) {
      exercises[exerciseIndex].notes = "";
    }

    exercises[exerciseIndex].hasNotes =
        exercises[exerciseIndex].hasNotes == 0 ? 1 : 0;

    notifyListeners();
  }

  void updateExerciseSetWeight(int exerciseIndex, int setIndex, String value) {
    exercises[exerciseIndex].sets[setIndex].weight = double.parse(value);
  }

  void updateExerciseSetReps(int exerciseIndex, int setIndex, String value) {
    exercises[exerciseIndex].sets[setIndex].reps = int.parse(value);
  }

  void deleteExerciseSet(int exerciseIndex, int setIndex) {
    if (exercises[exerciseIndex].sets.length > 1) {
      exercises[exerciseIndex].sets.removeAt(setIndex);

      notifyListeners();
    }
  }

  void addExerciseSet(int exerciseIndex) {
    exercises[exerciseIndex].sets.add(ExerciseSet());

    notifyListeners();
  }

  Workout convertToWorkout() {
    Workout _workout = new Workout(
      id: id,
      name: name ?? "",
      weightUnit: weightUnit ?? "kg",
      timeInMillisSinceEpoch:
          timeInMillisSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
      exercises: exercises ?? [],
      duration: duration ?? "00:00",
      workoutDurationInMilliseconds: workoutDurationInMilliseconds ?? 0,
      note: note ?? "",
    );

    return _workout;
  }

  WorkoutChangeNotifier fromJSON(Map<String, dynamic> workout) {
    List<Exercise> exerciseList = [];

    List<Map<String, dynamic>> exercisesJSON = workout['exercises'] ?? [];
    if (exercisesJSON.isNotEmpty) {
      exercisesJSON.forEach((Map<String, dynamic> exercise) {
        exerciseList.add(new Exercise().fromJSON(exercise));
      });
    }

    return new WorkoutChangeNotifier(
      id: workout['id'],
      name: workout['name'] ?? "",
      weightUnit: workout['weightUnit'] ?? "",
      timeInMillisSinceEpoch: workout['timeInMillisSinceEpoch'] ??
          DateTime.now().millisecondsSinceEpoch,
      exercises: exerciseList ?? [],
      duration: workout['workoutDuration'] ?? "00:00",
      workoutDurationInMilliseconds:
          workout['workoutDurationInMilliseconds'] ?? 0,
      note: workout['workoutNote'] ?? "",
    );
  }

  Map<String, dynamic> toJSON() {
    List<Map<String, dynamic>> exercisesJSON = [];

    if (exercises.isNotEmpty) {
      exercises.forEach((Exercise exercise) {
        exercisesJSON.add(exercise.toJSON());
      });
    }

    return {
      'id': id,
      'name': name ?? "",
      'weightUnit': weightUnit ?? "",
      'timeInMillisSinceEpoch':
          timeInMillisSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
      'exercises': exercisesJSON ?? [],
      'workoutDuration': duration ?? "00:00",
      'workoutDurationInMilliseconds': workoutDurationInMilliseconds ?? 0,
      'workoutNote': note ?? "",
    };
  }
}
