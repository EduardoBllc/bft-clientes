import 'package:flutter/cupertino.dart';

class MessagesProvider extends ChangeNotifier {
  String _weeklyMessage = "";
  // 'Opa.... boa tarde galera !!!         😇🫡 Começamos o mês de abril, bora ficar na régua 📏 os garotos @jean @bruno @mateus @fernando... estão com suas agendas liberadas para esta semana.... então só entrar no app.. e selecionar seu barbeiro 💈  boa semana a todos.... https://www.topagenda.com.br/?tel=5430251940';
  String _defaultBirthdayMessage = '';

  String get weeklyMessage => _weeklyMessage;
  set weeklyMessage(String message) {
    _weeklyMessage = message;
    notifyListeners();
  }

  String get defaultBirthdayMessage => _defaultBirthdayMessage;
  set defaultBirthdayMessage(String message) {
    _defaultBirthdayMessage = message;
    notifyListeners();
  }
}
