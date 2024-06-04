import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceManager {
  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("ANDROID ID ${androidInfo.id}");
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("IOS ID ${iosInfo.identifierForVendor}");
      return iosInfo.identifierForVendor ?? "";
    } else {
      print("ELSE ELSE");
      return "";
    }
  }
}
