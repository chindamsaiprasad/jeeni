import 'package:flutter/material.dart';
import 'package:jeeni/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {

  final Uri _url = Uri.parse('https://www.jeeni.in/privacy-policy');

  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}


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
      body: SingleChildScrollView(
        child: Container(
          
          
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black),
          //   color: Colors.white,
          //   borderRadius: BorderRadius.all(Radius.circular(15))
          //   // borderRadius: BorderRadius.only(
          //   //   topLeft: Radius.circular(15),
          //   //   topRight: Radius.circular(15),
          //   // ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Info

              navigationList(_launchUrl, Icons.abc_outlined, "About us",
              'Click here to know more about Privacy Policy'
              , Icons.arrow_right),
              // Text(
              //   'Why Jeeni?',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 16),
              // Text(
              //   'Jeeni offers a completely outsourced solution for managing online examinations for organizations. '
              //   'We provide a ready-to-use question bank and processes for managing tests, along with AI-based analytical reports for students and institutions. '
              //   'We offer a hosted question bank and facilities for customers to host and manage their private question banks, allowing them to dynamically generate question papers. '
              //   'NTA (National Testing Agency) recently announced complete online exams for JEE, and in 2019, NEET will also be completely online. \n \n'
              //   'This year, the MH CET (Maharashtra) exam is online as well. Most exams, including engineering/medical entrance, law, banking, etc., are already conducted online. '
              //   'Hence, there is a BIG opportunity for practice examinations for institutes offering these trainings.',
              //   textAlign: TextAlign.justify,
              //   style: TextStyle(
              //     fontSize: 16.0,
              //     height: 1.5, // Adjust line height for better readability
              //     fontFamily: 'Roboto', // Example of specifying a font family
              //     fontWeight: FontWeight.normal,
              //     color: Colors.black, // Example color specification
              //   ),
              // ),
        
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
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
