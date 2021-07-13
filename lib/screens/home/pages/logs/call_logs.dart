import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:teams_clone/screens/callscreens/pickup/pickup_layout.dart';
import 'package:teams_clone/screens/search/search_bar.dart';
import 'package:teams_clone/utils/utilities.dart';
import 'package:teams_clone/widgets/teams_appbar.dart';

import 'widgets/floating_button.dart';
import 'widgets/log_container.dart';

class CallLogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor:
            AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
        appBar: TeamsAppBar(
          title: "Calls",
          color: AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: AdaptiveTheme.of(context).theme.primaryColorDark,
              ),
              onPressed: () {
                Utils.navigateTo(context, SearchBar());
              },
            ),
          ],
        ),
        floatingActionButton: FloatingButton(),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogContainer(),
        ),
      ),
    );
  }
}
