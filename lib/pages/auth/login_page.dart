import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/auth/forgot_password_page.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/utils/constants.dart';
import 'package:jeeni/utils/device_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _userIdController =
      TextEditingController(text: "joshi4099"); //"joshi4100");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");

  // final TextEditingController _userIdController =
  //     TextEditingController(text: "joshi3052");
  // final TextEditingController _passwordController =
  //     TextEditingController(text: "123456");

  // final TextEditingController _userIdController =
  //     TextEditingController(text: "");
  // // TextEditingController(text: "joshi_1452");
  // final TextEditingController _passwordController =
  //     TextEditingController(text: "");

  final TextEditingController _phoneController = TextEditingController();

  late bool isLoading = false;
  bool _obscureText = true;

  bool forgotPasswordBool = true;

  Future<String> getDeviceId() async {
    if (kIsWeb) {
      return ''; // Return an empty string if the platform is web
    } else {
      return await DeviceManager().getDeviceId();
    }
  }

  Container _buildLogo() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstants.loginImageBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(ImageConstants.jeeniLoginLogoImage),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffebeae8),
      // backgroundColor: const Color(0xff1c5e20),
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        // backgroundColor: Colors.transparent,
        // title: const Text(
        //   "Login",
        //   style: TextStyle(color: Colors.white),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 80,),
            _buildLogo(),
            Container(
              margin: const EdgeInsets.only(left: 4, right: 4),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              // child: Container(
              //   height: 100,
              //   width: 100,
              //   color: Colors.red,
              // ),
              // child: forgotPasswordBool
              //     ? loginContainer()
              //     : forgotPasswordContainer(),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    forgotPasswordBool
                        ? loginContainer()
                        : forgotPasswordContainer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Login",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _userIdController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Student Id",
              labelStyle: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
              hintText: "Enter your student id"),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Password",
            labelStyle: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
            hintText: "Enter your password",
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.black45,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text.rich(
                TextSpan(
                  text: "Forgot password?",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _phoneController.clear();
                      setState(() {
                        forgotPasswordBool = !forgotPasswordBool;
                      });
                    },
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          // width: 120,
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: () async {
              if (isLoading) return;

              setState(() {
                isLoading = true;
              });

              final deviceId = await getDeviceId();

              ref
                  .read(authenticationProvider.notifier)
                  .loginWithIdAndPassword(
                    userId: _userIdController.text,
                    password: _passwordController.text,
                    deviceIMEI: deviceId,
                  )
                  .then((value) {
                print("THEN THEN $value");

                print("data ${value.statusCode}");

                if (value.statusCode == 200) {
                  // EasyLoading.showSuccess("Sucessfully logged in");
                } else if (value.statusCode == 401) {
                  EasyLoading.showError("Invalid UserName or Password");
                }
                // EasyLoading.showSuccess("Sucessfully logged in");
              }).catchError((error) {
                setState(() {
                  isLoading = false;
                });

                // print("data : ${error}");

                if (error is SocketException) {
                  EasyLoading.showError("Check your internet connectivity.");
                } else if (error is HttpException) {
                  EasyLoading.showError(
                      "An HTTP error occurred. Please try again later.");
                } else if (error is FormatException) {
                  EasyLoading.showError(
                      "Data format error. Please contact support.");
                } else {
                  EasyLoading.showError(
                      "An unexpected error occurred. Please try again later.");
                }
                // EasyLoading.showError("Please check your internet connection or try again later.");
              }).whenComplete(() => setState(() {
                        isLoading = false;
                      }));
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.green,
                  )
                : const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }

  Widget forgotPasswordContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _phoneController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Mobile Number",
            labelStyle: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: () {
              // if (isLoading) return;

              // setState(() {
              //   isLoading = true;
              // });
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.green,
                  )
                : const Text(
                    "Send password",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text.rich(
                TextSpan(
                  text: "Already had account Log-in",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        forgotPasswordBool = !forgotPasswordBool;
                      });
                    },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
