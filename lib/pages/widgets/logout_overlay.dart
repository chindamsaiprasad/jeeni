import 'package:flutter/material.dart';

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

  static void show({required BuildContext context, String title = ""}) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Container(
                // padding: const EdgeInsets.all(50),
                height: 200,
                width: MediaQuery.of(context).size.width * .70,
                color: Colors.white,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Logout"),
                    const Text(
                        "Do you really want to sign out? If yes then all downloaded files will delete permanently."),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text("NO"),
                          ),
                          TextButton(
                            onPressed: () {},
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
