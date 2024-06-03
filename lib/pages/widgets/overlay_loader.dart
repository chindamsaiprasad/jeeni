import 'package:flutter/material.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayLoader {
  static OverlayEntry? _overlayEntry;

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
                color: AppColour.darkGreen,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
