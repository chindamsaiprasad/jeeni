import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MenuType { home, settings, issueReport, logout }

final menuProvider = ChangeNotifierProvider((ref) => MenuProvider(ref: ref));

class MenuProvider with ChangeNotifier {
  final Ref ref;
  late MenuType selectedMenu = MenuType.home;

  MenuProvider({required this.ref});

  void setSelectedMenu(MenuType menuType) {
    selectedMenu = menuType;
    notifyListeners();
  }

  String getDisplayName() {
    switch (selectedMenu) {
      case MenuType.home:
        return "Home";
      case MenuType.settings:
        return "Settings";
      case MenuType.issueReport:
        return "Report Issues";
      case MenuType.logout:
        return "Logout";
    }
  }
}
