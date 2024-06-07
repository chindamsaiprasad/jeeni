import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController _userIdController = TextEditingController();

  late bool isLoading = false;
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
        title: const Text("Forgot password", style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          _buildLogo(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: _userIdController,
                    decoration: const InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
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
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff1c5e20)),
                      ),
                      onPressed: () {
                        if (isLoading) return;

                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              color: Colors.green,
                            )
                          : const Text("Send Password" , style: TextStyle(color: Colors.white),),
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
