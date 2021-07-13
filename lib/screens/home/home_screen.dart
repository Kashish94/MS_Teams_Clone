import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/enum/user_state.dart';
import 'package:teams_clone/provider/user_provider.dart';
import 'package:teams_clone/resources/auth_methods.dart';
import 'package:teams_clone/screens/home/pages/contacts/contact_screen.dart';
import 'package:teams_clone/shared/theme_builder.dart';
import 'package:teams_clone/resources/local_db/repository/log_repository.dart';
import 'package:teams_clone/screens/callscreens/pickup/pickup_layout.dart';
import 'package:teams_clone/utils/global_variables.dart';

import 'pages/chats/chat_list_screen.dart';
import 'pages/logs/call_logs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController pageController;
  int _page = 0;
  UserProvider userProvider;

  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );

      LogRepository.init(
        isHive: true,
        dbName: userProvider.getUser.uid,
      );
    });

    WidgetsBinding.instance.addObserver(this);

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    double _labelFontSize = 10;

    var cupertinoTabBar = ThemeBuilder(
      builder: (theme) => CupertinoTabBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,
                color: (_page == 0)
                    ? AdaptiveTheme.of(context).theme.primaryColor
                    : GlobalVariables.greyColor),
            title: Text(
              "Chats",
              style: TextStyle(
                  fontSize: _labelFontSize,
                  color: (_page == 0)
                      ? AdaptiveTheme.of(context).theme.primaryColor
                      : Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call,
                color: (_page == 1)
                    ? AdaptiveTheme.of(context).theme.primaryColor
                    : GlobalVariables.greyColor),
            title: Text(
              "Calls",
              style: TextStyle(
                  fontSize: _labelFontSize,
                  color: (_page == 1)
                      ? AdaptiveTheme.of(context).theme.primaryColor
                      : Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone,
                color: (_page == 2)
                    ? AdaptiveTheme.of(context).theme.primaryColor
                    : GlobalVariables.greyColor),
            title: Text(
              "Contacts",
              style: TextStyle(
                  fontSize: _labelFontSize,
                  color: (_page == 2)
                      ? AdaptiveTheme.of(context).theme.primaryColor
                      : Colors.grey),
            ),
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
    return PickupLayout(
      scaffold: ThemeBuilder(
        builder: (theme) => Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: PageView(
            children: <Widget>[
              ChatListScreen(),
              CallLogs(),
              ContactScreen(),
            ],
            controller: pageController,
            onPageChanged: onPageChanged,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: cupertinoTabBar,
            ),
          ),
        ),
      ),
    );
  }
}
