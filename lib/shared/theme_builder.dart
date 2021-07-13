import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/provider/theme_provider.dart';

class ThemeBuilder extends StatelessWidget {
  final Function(ThemeData) builder;

  const ThemeBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) => builder(provider.getTheme),
    );
  }
}
