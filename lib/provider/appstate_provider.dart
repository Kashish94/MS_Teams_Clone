import 'package:flutter/widgets.dart';
import 'package:teams_clone/enum/app_state.dart';

class AppStateProvider with ChangeNotifier {
  AppState _appState = AppState.IDLE;
  AppState get getAppState => _appState;

  bool _isLoading = false;
  bool get isAppLoading => _isLoading;

  String _loadingMessage;
  String get loadingMessage => _loadingMessage;

  void setAppStateTo(AppState appState, {String msg}) {
    _appState = appState;
    _loadingMessage = msg;
    _isLoading = _appState == AppState.LOADING ? true : false;
    notifyListeners();
  }

  void setToLoading({withMessage}) =>
      setAppStateTo(AppState.LOADING, msg: withMessage);

  void setToIdle() => setAppStateTo(AppState.IDLE);
}
