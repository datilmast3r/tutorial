import 'package:flutter/material.dart';

class PageReloadNotifier extends ChangeNotifier {
  void reloadProfilePage() {
    notifyListeners();
  }

  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
  }
}
