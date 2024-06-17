import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:
                  Image.asset(height: 100, "assets/images/jeeniloginimage.png"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c5e20),
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        // title: const Text("Forgot password", style: TextStyle(color: Colors.white),),
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
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 4, right: 4),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Forgot Password",style: TextStyle(color: Colors.black, fontSize: 22),),
                    const SizedBox(height: 20,),
                    TextField(
                      controller: _userIdController,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff1c5e20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
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
                            : const Text("Send password" , style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
