import 'package:flutter/material.dart';

class ViemoPlayerPage extends StatefulWidget {
  final String VivemotitleName;
  final String VivemoLink;
  const ViemoPlayerPage({super.key, required this.VivemotitleName , required this.VivemoLink});

  @override
  State<ViemoPlayerPage> createState() => _ViemoPlayerPageState();
}

class _ViemoPlayerPageState extends State<ViemoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text( widget.VivemotitleName,
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