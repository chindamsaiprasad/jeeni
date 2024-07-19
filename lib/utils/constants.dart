import 'package:intl/intl.dart';

final options = ["A", "B", "C", "D"];


String? formatDateString(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return null;
  }

  try {
    // Parse the input date string to a DateTime object
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd/MM/yyyy, hh:mm a').format(dateTime);

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


  static const String loginImageBg = "assets/images/loginImageBg.jpg";
  static const String profileImageBg = "assets/images/profileBg.jpg";
  
}