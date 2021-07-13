import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/provider/theme_provider.dart';
import 'package:teams_clone/screens/auth/log_out_screen.dart';
import 'package:teams_clone/screens/home/home_screen.dart';

import '../resources/auth_methods.dart';

/// This should be put at all entry points
class AuthStateBuilder extends StatefulWidget {
  final Widget loggedOutScreen;
  final Widget loggedInScreen;

  const AuthStateBuilder({
    Key key,
    this.loggedOutScreen,
    this.loggedInScreen,
  }) : super(key: key);

  @override
  _AuthStateBuilderState createState() => _AuthStateBuilderState();
}

class _AuthStateBuilderState extends State<AuthStateBuilder> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      AdaptiveThemeMode themeMode = await AdaptiveTheme.getThemeMode();

      if (themeMode.isDark) {
        Provider.of<ThemeProvider>(context, listen: false)
            .setTheme(AdaptiveTheme.of(context).darkTheme);
      } else {
        Provider.of<ThemeProvider>(context, listen: false)
            .setTheme(AdaptiveTheme.of(context).theme);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: AuthMethods.getAuthState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        }
        return LogOutScreen();
      },
    );
  }
}
