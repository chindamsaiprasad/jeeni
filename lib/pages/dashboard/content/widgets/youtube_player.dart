import 'package:flutter/material.dart';

class YoutubePlayerPage extends StatefulWidget {
  final String videoYtName;
  final String youtubeLink;
  const YoutubePlayerPage({super.key, required this.videoYtName, required this.youtubeLink});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text( widget.videoYtName,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(),
    );
  }
}