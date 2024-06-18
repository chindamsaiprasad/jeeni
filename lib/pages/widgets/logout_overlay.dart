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
              color: const Color.fromRGBO(0, 0, 0, 0).withOpacity(0.5),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 250,
                  width: MediaQuery.of(context).size.width * .85,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Logout",
                        style: TextStyle(color: Colors.black87, fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Are you sure you want to log out?\nAll downloaded files will be deleted permanently.",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: onTapNo,
                              style: ButtonStyle(
                                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                                ),
                              ),
                              child: const Text("NO"),
                            ),
                            const SizedBox(width: 30,),
                            ElevatedButton(
                              onPressed: onTapYes,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                                ),
                              ),
                              child: const Text("YES",style: TextStyle(color: Colors.white),),
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
                  padding: const EdgeInsets.only(top: 10,bottom: 10,right: 15,left: 15),
                  height: 200,
                  width: MediaQuery.of(context).size.width * .85,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Please Note!",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const Text(
                        "It looks like you are logged in from somewhere else. Please login again.",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 35,
                        width: 150,
                          child: ElevatedButton(
                            onPressed: onTapYes,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                              ),
                            ),
                            child: const Text(
                              'Login Again',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
