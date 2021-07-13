import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/provider/appstate_provider.dart';
import 'package:teams_clone/resources/auth_methods.dart';
import 'package:teams_clone/screens/home/home_screen.dart';
import 'package:teams_clone/utils/utilities.dart';

class GoogleSignInButton extends StatelessWidget {
  AppStateProvider _appStateProvider;

  void performGoogleSignin(context) async {
    _appStateProvider.setToLoading();

    FirebaseUser user = await AuthMethods.signIn();

    if (user != null) {
      print("User is not null");
      // If user does not exists
      authenticateUser(user, context: context);
    } else {
      print("User is null");
    }

    _appStateProvider.setToIdle();
  }

  void authenticateUser(FirebaseUser user, {@required context}) {
    AuthMethods.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        AuthMethods.addDataToDb(user).then((value) {
          Utils.pushAndRemovePrevious(context, HomeScreen());
        });
      } else {
        Utils.pushAndRemovePrevious(context, HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _appStateProvider = Provider.of<AppStateProvider>(context);

    return SignInButton(
      Buttons.Google,
      text: "Sign up with Google",
      onPressed: () => performGoogleSignin(context),
    );
  }
}
