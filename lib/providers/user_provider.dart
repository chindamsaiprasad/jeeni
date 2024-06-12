import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/utils/local_data_manager.dart';

final userProvider =
    ChangeNotifierProvider((ref) => UserProviderClass(ref: ref));

class UserProviderClass with ChangeNotifier {
  late UserProviderClass resultResponse;

  final Ref ref;
  UserProviderClass({
    required this.ref,
  });

  String userName = '';
  String userImageBase = '';
  String userEmail = '';

  final localDataManager = LocalDataManager();

  Future<Map<String, dynamic>> saveUserDetails() async {
    final jauth = ref.read(authenticationProvider)?.jauth;

    if (jauth == null) {
      throw Exception('Authentication token (jauth) is null');
    }

    Map<String, String> headers = {
      "Accept-Encoding": "gzip, deflate, br, zstd",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Jauth": jauth,
    };

    try {
      final response = await http.get(
        Uri.parse("$BASE_URL/student/getById"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        localDataManager
            .updateStudent(
                data['name'], data['email'], data['mobileProfileImage'])
            .then((success) {
          if (success) {
            print("Student updated successfully.");
          } else {
            print("Failed to update student.");
          }
        }).catchError((error) {
          print("Error updating student: $error");
        });

        return data;
      } else {
        // Request failed
        print('Failed to fetch data, status code: ${response.statusCode}');
        throw Exception(
            'Failed to fetch data, status code: ${response.statusCode}');
      }
    } catch (error) {
      // Network or parsing errors
      print('Error fetching data: $error');
      throw Exception('Error fetching data: $error');
    }
  }

  Future<String> changePassword(
      String email, String oldPassword, String newPassword) async {
    String message = "";
    final url = Uri.parse('$BASE_URL/student/changePassword');

    final jauth = ref.read(authenticationProvider)?.jauth;
    if (jauth == null) {
      throw Exception('Authentication token (jauth) is null');
    }

    Map<String, String> headers = {
      "Accept-Encoding": "gzip, deflate, br, zstd",
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      "Accept": "application/json",
      "Jauth": jauth,
    };

    Map<String, String> body = {
      'email': email,
      'oldPass': oldPassword,
      'newPass': newPassword,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      // print("ok first ${response.body} ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Success: ${response.statusCode} - ${response.body}");
        message = 'Password changed successfully';
      } else if (response.statusCode == 401) {
        print("Error: ${response.statusCode} - ${response.body}");
        message = response.body;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        message = response.body;
      }
    } catch (e) {
      print("data ${e}");
      message = "Error: $e";
    }
    return message;
  }

  Future<String> updateProfile(bodyData) async {
    String message = "";

    final jauth = ref.read(authenticationProvider)?.jauth;
    if (jauth == null) {
      throw Exception('Authentication token (jauth) is null');
    }

    final url = Uri.parse('https://exam.jeeni.in/Jeeni/student/profile/update');

    Map<String, String> headers = {
      "Accept-Encoding": "gzip, deflate, br, zstd",
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      "Accept": "application/json",
      "Jauth": jauth,
    };
    final payload = bodyData;

    // Make the POST request
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: payload,
      );

      // Check the status code for the result
      if (response.statusCode == 302) {
        // print("body $payload");
        print('Profile update request was redirected. ${response.body}');
        message = "Profile details updated sucessfully";

        // Handle redirection or further action if needed
      } else if (response.statusCode == 200) {
        print('Profile updated successfully. ${response.body}');
        message = "ok ";
      } else {
        print(
            'Failed to update profile. Status code: ${response.statusCode} ${response.body},');
        message = "some issues";
      }
    } catch (e) {
      print('Error occurred while updating profile: $e');
      message = "some issues";
    }

    return message;
  }

  Future<String> uploadImage(XFile imageFile) async {
    String message = "";
    final jauth = ref.read(authenticationProvider)?.jauth;

    if (jauth == null) {
      throw Exception('Authentication token (jauth) is null');
    }

    final url = Uri.parse('https://exam.jeeni.in/Jeeni/student/uploadImage');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url)
        ..headers['Jauth'] = jauth
        ..headers['Accept'] =
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7'
        ..headers['Accept-Encoding'] = 'gzip, deflate, br, zstd'
        ..headers['Accept-Language'] = 'en-US,en;q=0.9'
        ..headers['Cache-Control'] = 'max-age=0'
        ..headers['Connection'] = 'keep-alive'
        ..headers['Content-Type'] =
            'multipart/form-data; boundary=----WebKitFormBoundaryxMtfqb4N1IFBHFM2';

      // Create multipart file from image file
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        filename: imageFile.name,
      );

      // Add file to multipart request
      request.files.add(multipartFile);

      // Send the request
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200 || response.statusCode == 302) {
        print('Image uploaded successfully. ${response.body}');
        message = "Image uploaded successfully";
      } else {
        print(
            'Failed to upload image. Status code: ${response.statusCode} ${response.body}');
        message = "Failed to upload image. Please try again.";
      }
    } catch (e) {
      print('Error occurred while uploading image: $e');
      message =
          "An error occurred while uploading the image. Please try again.";
    }

    return message;
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<void> sendScreenshotLogs(File file) async {
  final String url = 'https://exam.jeeni.in/Jeeni/rest/login/sendScreenshotLogs';

  final jauth = ref.read(authenticationProvider)?.jauth;
  try {
    Map<String, String> headers = {
      "Accept-Encoding": "gzip, deflate, br, zstd",
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      "Accept": "application/json",
      "Jauth": jauth!,
    };
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);

    // Add the file to the request
    var multipartFile = await http.MultipartFile.fromPath(
      'files',
      file.path,
    );
    request.files.add(multipartFile);

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      // Read the response
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('Response: $responseString');
    } else {
      print('Failed to send screenshot logs. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


}
