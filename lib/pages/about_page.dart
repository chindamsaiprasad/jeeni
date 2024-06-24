import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
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
          
          padding: const EdgeInsets.all(15),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black),
          //   color: Colors.white,
          //   borderRadius: BorderRadius.all(Radius.circular(15))
          //   // borderRadius: BorderRadius.only(
          //   //   topLeft: Radius.circular(15),
          //   //   topRight: Radius.circular(15),
          //   // ),
          // ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Info
              Text(
                'Why Jeeni?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Jeeni offers a completely outsourced solution for managing online examinations for organizations. '
                'We provide a ready-to-use question bank and processes for managing tests, along with AI-based analytical reports for students and institutions. '
                'We offer a hosted question bank and facilities for customers to host and manage their private question banks, allowing them to dynamically generate question papers. '
                'NTA (National Testing Agency) recently announced complete online exams for JEE, and in 2019, NEET will also be completely online. \n \n'
                'This year, the MH CET (Maharashtra) exam is online as well. Most exams, including engineering/medical entrance, law, banking, etc., are already conducted online. '
                'Hence, there is a BIG opportunity for practice examinations for institutes offering these trainings.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5, // Adjust line height for better readability
                  fontFamily: 'Roboto', // Example of specifying a font family
                  fontWeight: FontWeight.normal,
                  color: Colors.black, // Example color specification
                ),
              ),
        
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
