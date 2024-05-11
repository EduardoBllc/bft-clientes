import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/cupertino.dart';

import '../../models/color_theme.dart';

class SettingsProvider extends ChangeNotifier {
  ColorTheme _appTheme = lightColorTheme;

  String _defaultBirthdayMessage = "";

  ColorTheme get appTheme => _appTheme;
  set appTheme(ColorTheme theme) {
    _appTheme = theme;
    notifyListeners();
  }

  String get defaultBirthdayMessage => _defaultBirthdayMessage;
  set defaultBirthdayMessage(String message) {
    _defaultBirthdayMessage = message;
    notifyListeners();
  }
}
