import 'package:flutter/material.dart';
import 'package:nebula/models/lands.dart';

import '../../providers/preferences_provider.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PreferencesProvider>().getRecentFilters();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isRemote = true;
  bool _isFullTime = true;
  String _dropdownValue = lands[0];

  @override
  Widget build(BuildContext context) {
    final oldFilters = context.watch<PreferencesProvider>().filters;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filter", style: Theme.of(context).textTheme.headline1),
            Text("Filter your data", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Remote Jobs :"),
                Switch(
                  value: _isRemote,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (newValue) {
                    setState(() {
                      _isRemote = newValue;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Full Time :"),
                Switch(
                  value: oldFilters["full_time"] == null ? _isFullTime : oldFilters["full_time"] as bool,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (newValue) {
                    setState(() {
                      _isFullTime = newValue;

                      if (oldFilters.containsKey("full_time")) {
                        oldFilters.update("full_time", (value) => _isFullTime);
                        context.read<PreferencesProvider>().saveFilters(oldFilters);
                      } else {
                        oldFilters["full_time"] = _isFullTime;
                        context.read<PreferencesProvider>().saveFilters(oldFilters);
                      }
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Location :"),
                SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  value: oldFilters["location"] == null ? _dropdownValue : oldFilters["location"].toString(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      _dropdownValue = newValue;

                      if (oldFilters.containsKey("location")) {
                        oldFilters.update("location", (value) => _dropdownValue);
                        context.read<PreferencesProvider>().saveFilters(oldFilters);
                      } else {
                        oldFilters["location"] = _dropdownValue;
                        context.read<PreferencesProvider>().saveFilters(oldFilters);
                      }
                    });
                  },
                  items: lands.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  "APPLY FILTERS",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
