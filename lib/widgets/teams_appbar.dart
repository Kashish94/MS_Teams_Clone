import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:teams_clone/widgets/appbar.dart';

class TeamsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final List<Widget> actions;
  final bool centerTitle;
  final Color color;

  const TeamsAppBar({
    Key key,
    @required this.title,
    @required this.actions,
    @required this.color,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: (title is String)
          ? Text(
              title,
              style: TextStyle(
                color: AdaptiveTheme.of(context).theme.primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            )
          : title,
      color: color,
      centerTitle: centerTitle,
      actions: actions, leading: null,
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}
