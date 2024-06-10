import 'package:flutter/material.dart';
import 'package:jeeni/utils/app_colour.dart';

class LogoutOverlay {
  static OverlayEntry? _overlayEntry;

  static Future showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('This is an alert dialog.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void show({
    required BuildContext context,
    String title = "",
    required VoidCallback onTapYes,
    required VoidCallback onTapNo,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: Colors.transparent.withOpacity(0.5),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: MediaQuery.of(context).size.width * .80,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Logout",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                      const Text(
                        "Do you really want to sign out? If yes then all downloaded files will delete permanently.",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: onTapNo,
                              child: const Text("NO"),
                            ),
                            TextButton(
                              onPressed: onTapYes,
                              child: const Text("YES"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class AlreadyLoggedInOverlay {
  static OverlayEntry? _overlayEntry;

  static void show({
    required BuildContext context,
    String title = "",
    required VoidCallback onTapYes,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: Colors.transparent.withOpacity(0.5),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: MediaQuery.of(context).size.width * .80,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Warning",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      const Text(
                        "You have already logged-in somewhere else.",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: onTapYes,
                          child: TextButton(
                            onPressed: onTapYes,
                            child: const Text(
                              'Login Again',
                              style: TextStyle(
                                color: AppColour.darkGreen,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
