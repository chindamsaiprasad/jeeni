import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final timerProvider = ChangeNotifierProvider((ref) => TimerService());

class TimerService extends ChangeNotifier {
  late Duration _duration;
  Timer? _timer;

  TimerService({Duration initialDuration = const Duration(minutes: 60)}) {
    _duration = initialDuration;
  }

  Duration get duration => _duration;

  void startTimer() {
    if (_timer != null && _timer!.isActive) {
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        _duration = _duration - Duration(seconds: 1);
      } else {
        timer.cancel();
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null; // Reset timer to null
    }
  }

  void updateDuration(int minutes) {
    stopTimer();
    _duration = Duration(minutes: minutes);
    notifyListeners();
  }
}