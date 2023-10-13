import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class ShowPasswordProvider extends ChangeNotifier {
  bool state = true;

  changeState() {
    state = !state;
    notifyListeners();
  }
}
