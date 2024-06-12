import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/auth/forgot_password_page.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/utils/device_manager.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // final TextEditingController _userIdController =
  //     TextEditingController(text: "joshi_352");
  // final TextEditingController _passwordController =
  //     TextEditingController(text: "Nish@nt1");

    final TextEditingController _userIdController =
      TextEditingController(text: "joshi3052");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");

  late bool isLoading = false;

  SizedBox _buildLogo() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Image.asset("assets/images/jeeniloginimage.png"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffebeae8),
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("Login",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          _buildLogo(),
          Container(
            margin: const EdgeInsets.all(10),
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: _userIdController,
                    decoration: const InputDecoration(
                      labelText: "Student Id",
                      labelStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ));
                              },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff1c5e20)),
                      ),
                      onPressed: () async {
                        if (isLoading) return;

                        setState(() {
                          isLoading = true;
                        });
                        final deviceId = await DeviceManager().getDeviceId();

                        ref
                            .read(authenticationProvider.notifier)
                            .loginWithIdAndPassword(
                              userId: _userIdController.text,
                              password: _passwordController.text,
                              deviceIMEI: deviceId,
                            )
                            .then((value) {
                          print("THEN THEN $value");
                        }).catchError((error) {
                          setState(() {
                            isLoading = false;
                          });
                          EasyLoading.showError("ERROR CODE :: $error ");
                        }).whenComplete(() => 
                          setState(() {
                            isLoading = false;
                          })
                        );
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              color: Colors.green,
                            )
                          : const Text("Login",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
