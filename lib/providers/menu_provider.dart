import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MenuType { home, settings, issueReport, logout, practiceTest }

final menuProvider = ChangeNotifierProvider((ref) => MenuProvider(ref: ref));

class MenuProvider with ChangeNotifier {
  final Ref ref;
  MenuType selectedMenu = MenuType.home;
  bool showLogout = false;
  MenuProvider({required this.ref});

  void setSelectedMenu(MenuType menuType) {
    selectedMenu = menuType;
    notifyListeners();
  }

  void toggleLogoutPopUp(bool open) {
    showLogout = open;
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
      case MenuType.practiceTest:
        return "Practice Test";
      // case MenuType.logoutPopUp:
      //   return "";
    }
  }

  void setLogOut(MenuType menuType) {
    selectedMenu = menuType;
    notifyListeners();
  }
}
