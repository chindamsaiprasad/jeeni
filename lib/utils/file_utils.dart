import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String?> loadFile(String fileName) async {
    final path = await _localPath;

    final file = File('$path/assets/$fileName');
    print("file.existsSync()  ${file.existsSync()}");
    print("file.existsSync()  $file");
    if (file.existsSync()) {
      return file.readAsString();
    }
    return null;
    // return await rootBundle.loadString(path);
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath;

    final file = File('$path/assets/$fileName');
    if (!file.existsSync()) {
      print("file.existsSync()  ${file.existsSync()}");
      return await file.create(recursive: true);
    }
    return file;
  }

  static Future<File> writeJson(
      Map<String, dynamic> jsonData, String fileName) async {
    final file = await _localFile(fileName);

    // Write the file

    print("ERROR :: WRITING TO FILE  :: 22222222222222222");
    return file.writeAsString(json.encode(jsonData));
  }

  static void writeJsonToFile(
      Map<String, dynamic> jsonData, String fileName) async {
    try {
      print("ERROR :: WRITING TO FILE  :: 111111111111111");
      await writeJson(jsonData, fileName).then((value) {
        print("ERROR :: WRITING TO FILE  :: 33333333333333333333 $value");
      });
    } catch (error) {
      print("ERROR :: WRITING TO FILE  :: $error");
    }

    // String jsonString = json.encode(jsonData);
    // try {
    //   Directory directory = await getApplicationDocumentsDirectory();

    //   String path = '${directory.path}/$filePath';
    //   print("directory ::  ${path}");
    //   // Ensure the directory exists
    //   final direc = await Directory(path).create(recursive: true);
    //   print("DIRECT :: $direc");

    //   File file = File(path);
    //   await file.writeAsString(jsonString);
    // } catch (e) {
    //   print("object $e");
    // }
  }
}
