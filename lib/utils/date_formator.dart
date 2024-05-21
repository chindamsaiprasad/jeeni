import 'package:intl/intl.dart';

class DateFormator {
  static getFormatedDate(int date) {
    var dt = DateTime.fromMillisecondsSinceEpoch(date);
// 12 Hour format:
    return DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM
  }
}

// 24 Hour format:
//    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);