import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teams_clone/screens/auth/main_auth_screen.dart';
import 'package:teams_clone/screens/onboarding/onboarding_screen.dart';

class LogOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool hasUserLandedForFirstTime = snapshot.data.get('is_first_time');
            if (hasUserLandedForFirstTime == null ||
                hasUserLandedForFirstTime) {
              return OnboardingScreen();
            } else {
              return MainAuthScreen();
            }
          }
          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
