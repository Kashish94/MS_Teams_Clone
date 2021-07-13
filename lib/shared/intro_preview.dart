import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:teams_clone/screens/search/search_bar.dart';
import 'package:teams_clone/shared/theme_builder.dart';

class QuietBox extends StatelessWidget {
  final String heading;
  final String subtitle;

  QuietBox({
    @required this.heading,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: AdaptiveTheme.of(context).theme.dividerColor,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: ThemeBuilder(
            builder: (theme) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: theme.primaryColorDark,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: theme.primaryColorDark,
                  ),
                ),
                SizedBox(height: 25),
                FlatButton(
                  color: AdaptiveTheme.of(context).theme.primaryColor,
                  child: Text(
                    "START SEARCHING",
                    style: TextStyle(color: theme.primaryColorLight),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchBar(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
