//UI for user details

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/enum/user_state.dart';
import 'package:teams_clone/models/user.dart';
import 'package:teams_clone/provider/theme_provider.dart';
import 'package:teams_clone/provider/user_provider.dart';
import 'package:teams_clone/resources/auth_methods.dart';
import 'package:teams_clone/screens/auth/main_auth_screen.dart';
import 'package:teams_clone/screens/chatscreens/widgets/cached_image.dart';
import 'package:teams_clone/shared/theme_builder.dart';
import 'package:teams_clone/widgets/appbar.dart';

import 'shimmering_logo.dart';

class UserDetails extends StatelessWidget {
  final AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    signOut() async {
      final bool isLoggedOut = await AuthMethods.signOut();
      if (isLoggedOut) {
        // set userState to offline as the user logs out'
        authMethods.setUserState(
          userId: userProvider.getUser.uid,
          userState: UserState.Offline,
        );

        // move the user to login screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainAuthScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return ThemeBuilder(
      builder: (theme) => Container(
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.primaryColorDark,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              color: theme.scaffoldBackgroundColor,
              centerTitle: true,
              title: ShimmeringLogo(
                backgroundColor: theme.primaryColorDark,
                foregroundColor: theme.primaryColorLight,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => signOut(),
                  child: Text(
                    "Sign Out",
                    style:
                        TextStyle(fontSize: 12, color: theme.primaryColorDark),
                  ),
                )
              ],
            ),
            UserDetailsBody(theme: theme),
          ],
        ),
      ),
    );
  }
}

class UserDetailsBody extends StatefulWidget {
  final ThemeData theme;

  const UserDetailsBody({Key key, @required this.theme}) : super(key: key);

  @override
  _UserDetailsBodyState createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    var children2 = <Widget>[
      Text(
        user.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: widget.theme.primaryColorDark,
        ),
      ),
      SizedBox(height: 10),
      Text(
        user.email,
        style: TextStyle(fontSize: 14, color: widget.theme.primaryColorDark),
      ),
      SizedBox(height: 30),
      Row(
        children: [
          Text(
            "SWITCH THEME : ",
            style: TextStyle(
              color: widget.theme.primaryColorDark,
            ),
          ),
          Switch.adaptive(
              activeColor: Colors.blueAccent,
              activeTrackColor: Colors.blue.withOpacity(0.4),
              value:
                  AdaptiveTheme.of(context).theme.brightness == Brightness.dark,
              onChanged: (value) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }

                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(AdaptiveTheme.of(context).theme);
                setState(() {});
              }),
        ],
      ),
      // );
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImage(
            user.profilePhoto,
            isRound: true,
            radius: 50,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children2,
          ),
        ],
      ),
    );
  }
}
