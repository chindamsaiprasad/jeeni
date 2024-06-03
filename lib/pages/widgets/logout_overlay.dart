import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/auth_provider.dart';

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
              child: Container(
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: MediaQuery.of(context).size.width * .80,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisAlignment: MainAxisAlignment.start,
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
