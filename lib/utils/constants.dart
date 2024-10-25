import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final options = ["A", "B", "C", "D"];
final PQRSOptions = ["p", "q", "r", "s"];

String? formatDateString(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return null;
  }

  try {
    // Parse the input date string to a DateTime object
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the DateTime object to the desired format
    // String formattedDate = DateFormat('dd/MM/yyyy, hh:mm a').format(dateTime);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  } catch (e) {
    // If parsing fails, return null
    return null;
  }
}

String formatEpochTime(int epochTime) {
  // Convert epoch time to DateTime object
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);

  // Define the date format
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  // Format the DateTime object to a string
  String formattedDate = dateFormat.format(dateTime);

  return formattedDate;
}

class ImageConstants {
  static const String appIconImage = "assets/images/appicon.png";
  static const String splashScreenImage = "assets/images/splash.png";
  static const String jeeniLoginLogoImage = "assets/images/jeeniloginimage.png";

  static const String vazeClassesLoginLogoImage = "assets/images/vazeclasses_logo.png";

  static const String loginImageBg = "assets/images/loginImageBg.jpg";
  static const String profileImageBg = "assets/images/profileBg.jpg";
}



  String convertEpochToCustomTimeZone(int? ipocTime) {
  // Check if the input is null
  if (ipocTime == null) {
    return '';
  }

  // Convert milliseconds to seconds
  int epochTime = (ipocTime / 1000).round();

  // Create a DateTime object from the epoch time
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: true);

  // Define the desired timezone (GMT+05:30)
  var desiredTimezone = 'Asia/Kolkata';

  // Set the desired time zone
  dateTime = dateTime.toUtc().add(const Duration(hours: 5, minutes: 30));

  // Format the DateTime object to the desired timezone and format it
  var formatter = DateFormat('dd/MM/yyyy').addPattern(' z');
  String convertedTime = formatter.format(dateTime);

  // Return the formatted time string
  return convertedTime;
}




class ThemeColorsPortableFile {
  // Define static colors for easy access
  static const Color appBarColor = Colors.blue;
  static const Color buttonColor = Colors.blue;

  // Additional colors
  static const Color appBarTextColor = Colors.black;
  static const Color buttonTextColor = Colors.black;
}