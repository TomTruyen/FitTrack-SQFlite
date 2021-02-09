import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import 'package:fittrack/models/settings/Settings.dart';
import 'package:fittrack/screens/settings/popups/data/DeleteDataPopup.dart';
import 'package:fittrack/screens/settings/popups/data/ExportDataPopup.dart';
import 'package:fittrack/screens/settings/popups/data/ImportDataPopup.dart';
import 'package:fittrack/screens/settings/popups/food/NutritionGoalsPopup.dart';
import 'package:fittrack/screens/settings/popups/rest_timer/DefaultRestTimePopup.dart';
import 'package:fittrack/screens/settings/popups/units/WeightUnitPopup.dart';
import 'package:fittrack/shared/Functions.dart';
import 'package:fittrack/shared/Globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Settings settings;
  PackageInfo packageInfo;

  @override
  void initState() {
    super.initState();

    settings = globals.sqlDatabase.settings;

    getPackageInfo();
  }

  Future<void> getPackageInfo() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      packageInfo = _packageInfo;
    });
  }

  void updateSettings(Settings _settings) {
    globals.sqlDatabase.settings = _settings;

    setState(() {
      settings = _settings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey[50],
            floating: true,
            pinned: true,
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () async {
                await globals.sqlDatabase.getSettings();

                tryPopContext(context);
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Units',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('Weight Unit'),
                  subtitle: Text(
                    settings.weightUnit == 'kg'
                        ? 'Metric (kg)'
                        : 'Imperial (lbs)',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    await showPopupWeightUnit(
                      context,
                      settings,
                      updateSettings,
                    );
                  },
                ),
                Divider(color: Color.fromRGBO(70, 70, 70, 1)),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Nutrition',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('Nutrition Goals'),
                  subtitle: Text(
                    'Set your nutrition goals',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    await showPopupNutritionGoals(
                      context,
                      updateSettings,
                      settings,
                    );
                  },
                ),
                // kcal, carbs, protein, fat goals
                Divider(color: Color.fromRGBO(70, 70, 70, 1)),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Rest Timer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('Default rest time'),
                  subtitle: Text(
                    settings.defaultRestTime > 60
                        ? "${settings.defaultRestTime ~/ 60}m ${(settings.defaultRestTime % 60).toString().padLeft(2, '0')}s"
                        : "${settings.defaultRestTime}s",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    await showPopupDefaultRestTime(
                      context,
                      updateSettings,
                      settings,
                    );
                  },
                ),
                SwitchListTile(
                  title: Text('Rest timer enabled'),
                  value: settings.isRestTimerEnabled == 1 ? true : false,
                  onChanged: (bool value) async {
                    Settings newSettings = settings.clone();
                    newSettings.isRestTimerEnabled =
                        newSettings.isRestTimerEnabled == 1 ? 0 : 1;

                    dynamic result =
                        await globals.sqlDatabase.updateSettings(newSettings);

                    if (result != null) {
                      updateSettings(newSettings);
                    }
                  },
                ),
                SwitchListTile(
                  title: Text('Vibrate upon finish'),
                  value:
                      settings.isVibrateUponFinishEnabled == 1 ? true : false,
                  onChanged: (bool value) async {
                    Settings newSettings = settings.clone();
                    newSettings.isVibrateUponFinishEnabled =
                        newSettings.isVibrateUponFinishEnabled == 1 ? 0 : 1;

                    dynamic result =
                        await globals.sqlDatabase.updateSettings(newSettings);

                    if (result != null) {
                      updateSettings(newSettings);
                    }
                  },
                ),
                Divider(color: Color.fromRGBO(70, 70, 70, 1)),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                ListTile(
                  title: Text('Import data'),
                  subtitle: Text(
                    'Imports data from a file',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    await showPopupImportData(context, updateSettings);
                  },
                ),
                ListTile(
                  title: Text('Export data'),
                  subtitle: Text(
                    'Exports data to a file',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    DateFormat dateFormat = new DateFormat("d-M-y-hms");
                    String date = dateFormat.format(DateTime.now());

                    String fileName = 'FitTrack-$date.db';

                    await showPopupExportData(
                      context,
                      fileName,
                      updateSettings,
                    );
                  },
                ),
                ListTile(
                  title: Text('Delete data'),
                  subtitle: Text(
                    'Deletes all your data',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    await showPopupDeleteData(context, updateSettings);
                  },
                ),
                if (packageInfo != null)
                  Divider(color: Color.fromRGBO(70, 70, 70, 1)),
                if (packageInfo != null)
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Version: ${packageInfo.version} - Build: ${packageInfo.buildNumber}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
