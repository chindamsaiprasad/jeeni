import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Container _buildLogo() {
    return Container(
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffebeae8),
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("Login"),
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
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Student Id",
                      labelStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "password",
                      labelStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text.rich(
                          TextSpan(
                            text: "forgot password?",
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()..onTap = () {},
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
                            MaterialStatePropertyAll(const Color(0xff1c5e20)),
                      ),
                      onPressed: () {},
                      child: const Text("login"),
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
