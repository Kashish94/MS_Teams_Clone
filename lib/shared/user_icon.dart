import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/provider/user_provider.dart';
import 'package:teams_clone/utils/global_variables.dart';
import 'package:teams_clone/utils/utilities.dart';

import '../screens/home/pages/chats/widgets/user_details.dart';

class UserIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    //To dismiss the screen by dragging down
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        //to cover the entire screen
        isScrollControlled: true,
        context: context,
        builder: (context) => UserDetails(),
      ),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AdaptiveTheme.of(context).theme.dividerColor,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getInitials(userProvider.getUser.name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AdaptiveTheme.of(context).theme.primaryColor,
                  fontSize: 13,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: GlobalVariables.blackColor, width: 2),
                  color: GlobalVariables.onlineDotColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
