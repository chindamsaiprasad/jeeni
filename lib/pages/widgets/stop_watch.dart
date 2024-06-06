// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  final Duration duration;
  final VoidCallback callback;
  const StopWatch({
    Key? key,
    required this.duration,
    required this.callback,
  }) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Timer? _timer;

  Duration? temperaryDuration;
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    temperaryDuration = Duration(
      seconds: widget.duration.inSeconds,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final tempSeconds = temperaryDuration?.inSeconds ?? 0;
      if (tempSeconds > 0) {
        setState(() {
          temperaryDuration = Duration(seconds: (tempSeconds - 1));
        });
      } else {
        _timer?.cancel();
        widget.callback();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(temperaryDuration ?? const Duration(seconds: 0)),
      style: const TextStyle(
        fontSize: 28,
        color: Colors.red,
      ),
    );
  }
}
