import 'package:flutter/material.dart';
import 'package:jeeni/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsPage extends StatelessWidget {



  final WebViewController controller;
  const AboutUsPage({required this.controller});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff1c5e20),
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }


  Widget navigationList(VoidCallback ontap, IconData leadingIcon,
      String titleText, String subTitleText, IconData trallingIcon) {
    return ListTile(
      onTap: ontap,
      leading: JeeniIcon(iconData: leadingIcon),
      title: Text(titleText),
      subtitle: Text(subTitleText),
      trailing: Icon(trallingIcon),
    );
  }
}
