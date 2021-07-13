import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:teams_clone/utils/global_variables.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: GlobalVariables.fabGradient,
          ),
          child: Icon(
            Icons.dialpad,
            color: Colors.white,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
              border: Border.all(
                width: 2,
                color: AdaptiveTheme.of(context).theme.primaryColor,
              )),
          child: Icon(
            Icons.add_call,
            color: AdaptiveTheme.of(context).theme.primaryColor,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}
