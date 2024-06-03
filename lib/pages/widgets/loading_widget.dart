import 'package:flutter/material.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayLoaderTwo extends StatelessWidget {
  final String title;

  OverlayLoaderTwo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {}, // Prevent taps from passing through
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColour.darkGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
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
  }
}

class OverlayLoaderWrapperTwo extends StatelessWidget {
  final bool isLoading;
  final String title;

  OverlayLoaderWrapperTwo({
    required this.isLoading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading ? OverlayLoaderTwo(title: title) : SizedBox.shrink();
  }
}
