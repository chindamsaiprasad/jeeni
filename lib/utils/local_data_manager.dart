import 'dart:convert';

import 'package:jeeni/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager {
  static final LocalDataManager _singleton = LocalDataManager._internal();
  LocalDataManager._internal();

  SharedPreferences? _sharedPreferences;
  factory LocalDataManager() {
    return _singleton;
  }

  Future<SharedPreferences> init() async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<bool> storeStudent(Student student) {
    return init().then(
      (sharedPreferences) async {
        return await sharedPreferences.setString("STUDENT", student.toJson());
      },
    );
  }

  Future<Student> loadStudentFromLocal() {
    return init().then((sharedPreferences) async {
      if (sharedPreferences.getString("STUDENT") == null ||
          sharedPreferences.getString("STUDENT") == "") {
        throw Exception("Student Logout");
      }

      Map<String, dynamic> studentMap =
          jsonDecode(sharedPreferences.getString("STUDENT")!);
      return Student.fromMap(studentMap);
    });
  }

  Future<bool> clearLocalDatabase() {
    return init().then((sharedPreferences) async {
      return sharedPreferences.setString("STUDENT", "");
    });
  }
}
