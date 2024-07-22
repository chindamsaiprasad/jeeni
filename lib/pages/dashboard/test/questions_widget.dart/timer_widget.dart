import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/providers/test_time._provider.dart';

class TimerWidget extends ConsumerWidget {
  const TimerWidget({super.key});

  void checkAndSubmitTest(WidgetRef ref, BuildContext context) {
    final timerService = ref.read(timerProvider);
    if (timerService.duration == Duration.zero) {
      OverlayLoader.show(context: context, title: "Submitting");
      print("this wroks");
      ref.read(testProgressProvider).submitTest().then((response) {
        if (response != null) {
          timerService.stopTimer();
          Navigator.pop(context, response);
        }
      }).catchError((onError) {
        // Handle error
        print("111111111111111111111111111111111 ERROR");
      }).whenComplete(() {
        print("111111111111111111111111111111111 whenComplete");

        OverlayLoader.hide();
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerService = ref.watch(timerProvider);
    int hours = timerService.duration.inHours;
    int minutes = timerService.duration.inMinutes.remainder(60);
    int seconds = timerService.duration.inSeconds.remainder(60);

    if (timerService.duration == Duration.zero) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkAndSubmitTest(ref, context);
      });
    }

    return Text(
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
}
