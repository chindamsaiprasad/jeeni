import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/user_provider.dart';
import 'package:http/http.dart' as http;

// final resetPasswordProvider = ChangeNotifierProvider((ref) => ResetPassDailog(ref));

class ResetPassDailog extends ChangeNotifier {
  // late Ref ref;
  // ResetPassDailog(this.ref);

  void showResetPassword(
    BuildContext context,
    String jauth,
    String email,
    String password,
    VoidCallback onButtonPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _isPasswordVisible = true;
        bool _isPasswordVisibleTwo = true;

        TextEditingController newPasswordController = TextEditingController();
        TextEditingController confirmPasswordController =
            TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  shape: BoxShape
                      .rectangle, // Explicitly setting the shape to rectangle
                  borderRadius:
                      BorderRadius.circular(0), // Adding rounded corners
                ),
                // color: Colors.green,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      color: const Color(0xff1c5e20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Reset password ",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 230,
                      width: 400,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: newPasswordController,
                                  obscureText: _isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "Enter Password",
                                    border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        // print("$_isPasswordVisible");
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: confirmPasswordController,
                                  obscureText: _isPasswordVisibleTwo,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "Enter Password",
                                    border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisibleTwo
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        // print("$_isPasswordVisible");
                                        setState(() {
                                          _isPasswordVisibleTwo =
                                              !_isPasswordVisibleTwo;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    // Navigator.of(context).pop();
                                    // Navigator.pop(context, true);
                                    if (newPasswordController.text.isEmpty &&
                                        confirmPasswordController
                                            .text.isEmpty) {
                                      EasyLoading.showError(
                                          "New password and confirm password shouldn't be empty");
                                    } else if (newPasswordController
                                        .text.isEmpty) {
                                      EasyLoading.showError(
                                          "New password shouldn't be empty");
                                    } else if (confirmPasswordController
                                        .text.isEmpty) {
                                      EasyLoading.showError(
                                          "Confirm password shouldn't be empty");
                                    } else if (newPasswordController.text !=
                                        confirmPasswordController.text) {
                                      EasyLoading.showError(
                                          "New password and confirm password don't match");
                                    } else {
                                      print(
                                          "pass ${email} ${password} ${newPasswordController.text}");

                                      // String data = await ref.read(userProvider).changePassword(email, password, newPasswordController.text);
                                      // ref.read(userProvider).changePassword(email, password, newPasswordController.text);

                                      String data = await changePassword(
                                          jauth,
                                          email,
                                          password,
                                          newPasswordController.text);

                                      if (data ==
                                          "Password changed successfully") {
                                        EasyLoading.showSuccess(data);
                                        onButtonPressed();
                                        Navigator.of(context).pop();
                                      } else {
                                        EasyLoading.showError(data);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(0xff1c5e20), // Background color
                                    foregroundColor: Colors.white, // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners
                                    ),
                                  ),
                                  child: Text('Reset Password'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<String> changePassword(String jauth, String email, String oldPassword,
      String newPassword) async {
    String message = "";

    final url = Uri.parse('$BASE_URL/student/changePassword');

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
}
