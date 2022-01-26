import 'package:fitoryx/models/exercise.dart';
import 'package:fitoryx/models/popup_option.dart';
import 'package:fitoryx/models/workout_change_notifier.dart';
import 'package:fitoryx/screens/exercises/exercises_page.dart';
import 'package:fitoryx/widgets/form_input.dart';
import 'package:fitoryx/widgets/popup_menu.dart';
import 'package:fitoryx/widgets/rest_dialog.dart';
import 'package:fitoryx/widgets/time_header_row.dart';
import 'package:fitoryx/widgets/time_set_row.dart';
import 'package:fitoryx/widgets/weight_header_row.dart';
import 'package:fitoryx/widgets/weight_set_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final int index;
  final Exercise exercise;

  final List<PopupOption> _popupOptions = [
    PopupOption(text: 'Rest timer', value: 'rest'),
    PopupOption(text: 'Replace exercise', value: 'replace'),
    PopupOption(text: 'Remove exercise', value: 'remove'),
  ];

  WorkoutExerciseCard({Key? key, required this.index, required this.exercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkoutChangeNotifier _workout =
        Provider.of<WorkoutChangeNotifier>(context);

    return Card(
      key: UniqueKey(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    0.0,
                    16.0,
                    12.0,
                  ),
                  child: Text(
                    exercise.getTitle(),
                    style: TextStyle(color: Colors.blue[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              PopupMenu(
                items: _popupOptions,
                onSelected: (selected) {
                  switch (selected) {
                    case 'rest':
                      showRestDialog(
                        context,
                        _workout,
                        exercise,
                      );
                      break;
                    case 'replace':
                      _workout.replaceIndex = index;

                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (BuildContext context) => ExercisesPages(
                            isSelectable: true,
                            isReplace: true,
                            workout: _workout,
                          ),
                        ),
                      );
                      break;
                    case 'remove':
                      _workout.removeExercise(index);
                      break;
                    default:
                      break;
                  }
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
            child: FormInput(
              hintText: 'Exercise notes',
              maxLines: null,
              isDense: true,
              initialValue: exercise.notes,
              onChanged: (String value) {
                exercise.notes = value.trim();
              },
            ),
          ),
          exercise.type == 'time'
              ? const TimeHeaderRow()
              : WeightHeaderRow(unit: _workout.unit),
          for (int i = 0; i < exercise.sets.length; i++)
            Container(
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: exercise.type == 'time'
                  ? TimeSetRow(exerciseIndex: index, setIndex: i)
                  : WeightSetRow(exerciseIndex: index, setIndex: i),
            ),
          TextButton(
            child: Text(
              'ADD SET',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              _workout.addSet(index);
            },
          )
        ],
      ),
    );
  }
}
