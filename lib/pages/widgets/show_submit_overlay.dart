import 'package:flutter/material.dart';

class ShowSubmitOverlay {
  static OverlayEntry? _overlayEntry;

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
                        "Submit Test",
                        style: TextStyle(color: Colors.black87, fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Are you sure you want to submit?",
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