import 'package:flutter/material.dart';

class PdfViwerPage extends StatefulWidget {
  final String pdfTitleName;
  final String pdfLink;
  const PdfViwerPage({super.key, required this.pdfTitleName, required this.pdfLink});

  @override
  State<PdfViwerPage> createState() => _PdfViwerPageState();
}

class _PdfViwerPageState extends State<PdfViwerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text( widget.pdfTitleName,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:Container(),
    );
  }
}