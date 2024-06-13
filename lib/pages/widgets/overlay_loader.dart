import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayLoader {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static bool _showButton = false;

  static void show({required BuildContext context, String title = ""}) {
    _showButton = false; // Reset button visibility
    _timer = Timer(Duration(seconds: 40), () {
      _showButton = true;
      _overlayEntry?.markNeedsBuild();
    });

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * .70,
                color: AppColour.darkGreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: AppColour.darkGreen,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      child: Text(title),
                    ),
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 80,
                    ),
                    if (_showButton)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            hide();
                          },
                          child: Text('Cancel'),
                        ),
                      ),
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
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}