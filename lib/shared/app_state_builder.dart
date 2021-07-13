import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/enum/app_state.dart';
import 'package:teams_clone/provider/appstate_provider.dart';

class AppStateBuilder extends StatelessWidget {
  final Widget child;

  AppStateBuilder({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: <Widget>[
            child,
            (provider.getAppState == AppState.IDLE)
                ? Container()
                : Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
