import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> loadFile(String path) async {
    return await rootBundle.loadString(path);
  }

  static void writeJsonToFile(
      Map<String, dynamic> jsonData, String filePath) async {
    String jsonString = json.encode(jsonData);
    try {
      Directory directory = await getApplicationDocumentsDirectory();

      String path = '${directory.path}/$filePath';
      print("directory ::  ${path}");
      // Ensure the directory exists
      final direc = await Directory(path).create(recursive: true);
      print("DIRECT :: $direc");

      File file = File(path);
      await file.writeAsString(jsonString);
    } catch (e) {
      print("object $e");
    }
  }
}
