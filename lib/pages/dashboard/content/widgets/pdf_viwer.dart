import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PdfViwerPage extends StatefulWidget {
  final String pdfTitleName;
  final String pdfLink;
  const PdfViwerPage({super.key, required this.pdfTitleName, required this.pdfLink});

  @override
  State<PdfViwerPage> createState() => _PdfViwerPageState();
}

class _PdfViwerPageState extends State<PdfViwerPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.list,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body:Container(
        child: SfPdfViewer.network(
          widget.pdfLink,
          pageLayoutMode:
              PdfPageLayoutMode.continuous,
          scrollDirection:
              PdfScrollDirection.vertical,
          key: _pdfViewerKey,
          // controller: _pdfViewerController,
        ),
      ),
    );
  }
}