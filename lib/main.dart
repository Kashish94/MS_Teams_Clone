import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/provider/appstate_provider.dart';
import 'package:teams_clone/provider/color_provider.dart';
import 'package:teams_clone/provider/image_upload_provider.dart';
import 'package:teams_clone/provider/theme_provider.dart';
import 'package:teams_clone/provider/user_provider.dart';
// import 'package:teams_clone/resources/auth_methods.dart';
// import 'package:teams_clone/screens/auth/main_auth_screen.dart';
import 'package:teams_clone/shared/auth_state_builder.dart';
import 'package:teams_clone/utils/global_variables.dart';

// import 'resources/auth_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(themeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode themeMode;

  MyApp({Key key, this.themeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.amber,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.black,
        dividerColor: Color(0xffE5E4E2),
        shadowColor: Color(0xffcea2fd),
        errorColor: Color(0xffC0C0C0),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GlobalVariables.blackColor,
        primaryColor: Colors.purple.shade200,
        accentColor: Colors.amber,
        primaryColorLight: Colors.black,
        primaryColorDark: Colors.white,
        dividerColor: Color(0xff272c35),
        shadowColor: Color(0xffb39ec7),
        errorColor: Color(0xffcdd8dd),
      ),
      initial: themeMode,
      builder: (theme, darkTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => AppStateProvider()),
          ChangeNotifierProvider(create: (_) => ColorProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: MaterialApp(
          title: "Teams Clone",
          debugShowCheckedModeBanner: false,
          home: AuthStateBuilder(),
        ),
      ),
    );
  }
}
