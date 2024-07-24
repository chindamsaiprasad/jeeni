import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/content/widgets/pdf_viwer.dart';
import 'package:jeeni/pages/dashboard/content/widgets/viemo_player.dart';
import 'package:jeeni/pages/dashboard/content/widgets/youtube_player.dart';
import 'package:jeeni/response_models/content_response.dart';
import 'package:jeeni/utils/app_colour.dart';

class SubjectPage extends ConsumerStatefulWidget {
  final Chapter chapter;
  const SubjectPage({
    required this.chapter,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectPageState();
}

class _SubjectPageState extends ConsumerState<SubjectPage> {
  List<Content> contentData = [];
  Content? selectedChapter;

  @override
  void initState() {
    super.initState();
    contentData = widget.chapter.content ?? [];
    selectedChapter = contentData.isNotEmpty ? contentData.first : null;
  }



  void navigateToContent(BuildContext context, Content content) {
    switch (content.contentType) {
      case 'LMS':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViwerPage(pdfTitleName: content.nameOfContent ?? '', pdfLink: content.contentLink ?? '',),
          ),
        );
        break;
      case 'Youtube':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YoutubePlayerPage(videoYtName: content.nameOfContent ?? '', youtubeLink: content.contentLink ?? '',),
          ),
        );
        break;
      case 'Vimeo':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViemoPlayerPage(VivemotitleName: content.nameOfContent ?? '', VivemoLink: content.contentLink ?? '',),
          ),
        );
        break;
      default:
        // Handle other content types if necessary
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text(
          widget.chapter.chapterName ?? "", 
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView(
                children: contentData
                    .map(
                      (content) => InkWell(
                        onTap: () => navigateToContent(context, content),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(content.nameOfContent ?? ""),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )),
              SizedBox(height: 5,)
        ],
      ),
    );
  }
}
