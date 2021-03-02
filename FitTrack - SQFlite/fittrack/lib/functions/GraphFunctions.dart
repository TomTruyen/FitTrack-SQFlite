import 'package:fittrack/models/settings/UserWeight.dart';
import 'package:fittrack/models/workout/Workout.dart';
import 'package:fittrack/functions/Functions.dart';

List<UserWeight> getUserWeightsWithinTimespan(
  List<UserWeight> userWeights,
  int timespan,
) {
  List<UserWeight> userWeightsWithinTimespan = [];

  DateTime now = DateTime.now();

  DateTime mostRecentDateTime = DateTime.fromMillisecondsSinceEpoch(
    userWeights[userWeights.length - 1].timeInMilliseconds,
  );

  if (!hasSameDayUserWeights(userWeights, mostRecentDateTime)) {
    UserWeight mostRecentClone = userWeights[userWeights.length - 1].clone();
    mostRecentClone.timeInMilliseconds = now.millisecondsSinceEpoch;
    userWeights.add(mostRecentClone);

    mostRecentDateTime = now;
  }

  DateTime latestDateTimeAllowed = mostRecentDateTime.subtract(
    Duration(days: timespan),
  );

  for (int i = 0; i < userWeights.length; i++) {
    if (timespan == -1) {
      userWeightsWithinTimespan.add(userWeights[i]);
    } else {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        userWeights[i].timeInMilliseconds,
      );
      if (date.isAfter(latestDateTimeAllowed) ||
          isSameDay(date, latestDateTimeAllowed)) {
        userWeightsWithinTimespan.add(userWeights[i]);
      }
    }
  }

  if (userWeightsWithinTimespan.isNotEmpty &&
      (userWeightsWithinTimespan.length < 2 ||
          !hasSameDayUserWeights(
            userWeightsWithinTimespan,
            latestDateTimeAllowed,
          ))) {
    UserWeight _clone = userWeightsWithinTimespan[0].clone();
    _clone.timeInMilliseconds =
        now.subtract(Duration(days: timespan)).millisecondsSinceEpoch;

    userWeightsWithinTimespan.insert(0, _clone);
  }

  return userWeightsWithinTimespan;
}

List<Workout> getWorkoutHistoryWithinTimespan(
  List<Workout> workoutHistory,
  int timespan,
) {
  List<Workout> workoutHistoryWithinTimespan = [];

  DateTime now = DateTime.now();

  DateTime mostRecentDateTime = DateTime.fromMillisecondsSinceEpoch(
    workoutHistory[workoutHistory.length - 1].timeInMillisSinceEpoch,
  );

  if (!hasSameDayWorkoutHistory(workoutHistory, mostRecentDateTime)) {
    Workout mostRecentClone = workoutHistory[workoutHistory.length - 1].clone();
    mostRecentClone.timeInMillisSinceEpoch = now.millisecondsSinceEpoch;
    workoutHistory.add(mostRecentClone);

    mostRecentDateTime = now;
  }

  DateTime latestDateTimeAllowed = mostRecentDateTime.subtract(
    Duration(days: timespan),
  );

  for (int i = 0; i < workoutHistory.length; i++) {
    if (timespan == -1) {
      workoutHistoryWithinTimespan.add(workoutHistory[i]);
    } else {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        workoutHistory[i].timeInMillisSinceEpoch,
      );

      if (date.isAfter(latestDateTimeAllowed) ||
          isSameDay(date, latestDateTimeAllowed)) {
        workoutHistoryWithinTimespan.add(workoutHistory[i]);
      }
    }
  }

  if (workoutHistoryWithinTimespan.isNotEmpty &&
      (workoutHistoryWithinTimespan.length < 2 ||
          !hasSameDayWorkoutHistory(
              workoutHistoryWithinTimespan, latestDateTimeAllowed))) {
    Workout _clone = workoutHistoryWithinTimespan[0].clone();
    _clone.timeInMillisSinceEpoch =
        now.subtract(Duration(days: timespan)).millisecondsSinceEpoch;

    workoutHistoryWithinTimespan.insert(0, _clone);
  }

  return workoutHistoryWithinTimespan;
}

String getTitle(double value, List<String> _datesList) {
  int _value = value.toInt();

  if (value < 0) value = 0;
  if (_value > _datesList.length - 1) _value = _datesList.length - 1;

  return _datesList[_value];
}

String getTitleWithoutYear(double value, List<String> _datesList) {
  int _value = value.toInt();

  if (value < 0) value = 0;
  if (_value > _datesList.length - 1) _value = _datesList.length - 1;

  String _date = _datesList[_value];
  List<String> _splittedDate = _date.split('-');
  _splittedDate.removeLast();

  return _splittedDate.join('-');
}