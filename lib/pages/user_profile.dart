import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/widgets/loading_widget.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/result_provider.dart';
import 'package:jeeni/providers/user_provider.dart';
import 'package:jeeni/utils/local_data_manager.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  final VoidCallback callback;
  const UserProfilePage({super.key, required this.callback});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
////////////////////  image picker
  XFile? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(BuildContext context) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = pickedFile;
      });

      
      ref.read(userProvider).uploadImage(pickedFile);
    }
  }

  Widget _buildInlineImage(XFile file) {
    return Center(
      child: Image.file(
        File(file.path),
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return const Center(child: Text('This image type is not supported'));
        },
      ),
    );
  }

  //////////////////////////////
  bool _isEditing = false;

  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentMobileController = TextEditingController();
  TextEditingController collegeNameController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController parentEmailController = TextEditingController();
  TextEditingController parentMobileController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController batchNameController = TextEditingController();

  String existingPassword = "";

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool boolCurrentPass = true;
  bool boolNewPass = true;
  bool boolConfirmPass = true;

  bool boolName = false;
  bool boolEmail = false;
  bool boolMobile = false;
  bool boolCollege = false;
  bool boolPName = false;
  bool boolPEmail = false;
  bool boolPMobile = false;
  bool boolCity = false;
  bool boolOrganization = false;

  bool isLoading = true;
  bool changePassword = true;
  String? imageString;

  Uint8List dataImage = Uint8List(0);

  @override
  void initState() {
    super.initState();
    getuserData();
  }

  void getuserData() async {
    try {
      final user = await ref.read(userProvider).saveUserDetails();

      // print('User data: ${user} ${user['institute']}');

      setState(() {
        // Update your state variables if needed
        studentNameController.text = user['name'] ?? '';
        studentEmailController.text = user['email'] ?? '';
        studentMobileController.text = user['mobileNumber'] ?? '';
        collegeNameController.text = user['collegeName'] ?? '';
        parentNameController.text = user['parentName'] ?? '';
        parentEmailController.text = user['parentEmail'] ?? '';
        parentMobileController.text = user['parentMobileNumber'] ?? '';
        cityNameController.text = user['city'] ?? '';
        orgNameController.text = user['institute'] ?? '';
        batchNameController.text = user['batchName'] ?? '';

        existingPassword = user['password'] ?? '';

        imageString = user['mobileProfileImage'] ?? '';

        dataImage = base64Decode(user['mobileProfileImage'] ?? '');
      });
    } catch (error) {
      // Handle error if necessary
      print('Error fetching user data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    studentNameController.dispose();
    studentEmailController.dispose();
    studentMobileController.dispose();
    collegeNameController.dispose();
    parentNameController.dispose();
    parentEmailController.dispose();
    parentMobileController.dispose();
    cityNameController.dispose();
    orgNameController.dispose();
    batchNameController.dispose();

    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // if (widget.callback != null) {
            //   widget.callback();
            // }

            widget.callback();
            Navigator.pop(context);
           
          },
        ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  firstContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  secondContainer(),
                  const SizedBox(
                    height: 5,
                  ),
                  thirdContainerPassword(),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: OverlayLoaderWrapperTwo(
                  isLoading: isLoading,
                  title: "Loading...",
                ),
              ),
          ],
        ));
  }

  Widget firstContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserDetailsContainer(imageString),
          const SizedBox(height: 10), // Add spacing between image and text
          Text(
            studentNameController.text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            studentEmailController.text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget secondContainer() {

    void clearAllSaved() {
    setState(() {
      boolName = false;
      boolEmail = false;
      boolMobile = false;
      boolCollege = false;
      boolPName = false;
      boolPEmail = false;
      boolPMobile = false;
      boolCity = false;
      boolOrganization = false;
    });
  }

    void updateUserDetails(payload) async{

      final data = await ref.read(userProvider).updateProfile(payload);

      if(data == "Profile details updated sucessfully"){
        EasyLoading.showSuccess(data);
        getuserData();
        clearAllSaved();
      } else{
        EasyLoading.showError(data);
      }

    }

    Row updateUserInfoButton(){
      return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: () {

                    final payload = {
                      'name': studentNameController.text,
                      'email': studentEmailController.text,
                      'mobileNumber': studentMobileController.text,
                      'parentMobileNumber': parentMobileController.text,
                      'parentEmail': parentEmailController.text,
                      'collegeName': collegeNameController.text,
                      'city': cityNameController.text,
                      'institute': orgNameController.text,
                      'batchName': batchNameController.text,
                    };

                    // print("data $payload");

                    updateUserDetails(payload);
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1c5e20),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  child: Text("Save Details"),
                ),
              ),
            ],
          );
    }

    return Container(
      // color:Colors.red,
      child: Column(
        children: [
          textFieldWidget(
            "Student Name",
            boolName,
            studentNameController,
            () {
              setState(() {
                boolName = !boolName;
                if (boolName) {
                  // print("Editing Student Name started");
                } else {
                  // print("Editing Student Name ended");
                }
              });
            },
            iconData: Icons.edit,
          ),
          textFieldWidget(
            "Student Email",
            boolEmail,
            studentEmailController,
            () {
              // setState(() {
              //   boolEmail = !boolEmail;
              //   if (boolEmail) {
              //     print("Editing Student Email started");
              //   } else {
              //     print("Editing Student Email ended");
              //   }
              // });
            },
            iconData: Icons.mail,
          ),
          textFieldWidget(
            "Student Mobile",
            boolMobile,
            studentMobileController,
            () {
              setState(() {
                boolMobile = !boolMobile;
                if (boolMobile) {
                  // print("Editing Student Mobile started");
                } else {
                  // print("Editing Student Mobile ended");
                }
              });
            },
            maxChars: 10,
            isNumber: true,
            iconData: Icons.edit,
          ),
          textFieldWidget(
            "College",
            boolCollege,
            collegeNameController,
            () {
              setState(() {
                boolCollege = !boolCollege;
                if (boolCollege) {
                  // print("Editing College started");
                } else {
                  // print("Editing College ended");
                }
              });
            },
            iconData: Icons.edit,
          ),
          // textFieldWidget(
          //   "Parent Name",
          //   boolPName,
          //   parentNameController,
          //   () {
          //     setState(() {
          //       boolPName = !boolPName;
          //       if (boolPName) {
          //         // print("Editing Parent Name started");
          //       } else {
          //         // print("Editing Parent Name ended");
          //       }
          //     });
          //   },
          //   iconData: Icons.edit,
          // ),
          textFieldWidget(
            "Parent Email",
            boolPEmail,
            parentEmailController,
            () {
              setState(() {
                boolPEmail = !boolPEmail;
                if (boolPEmail) {
                  // print("Editing Parent Email started");
                } else {
                  // print("Editing Parent Email ended");
                }
              });
            },
            iconData: Icons.edit,
          ),
          textFieldWidget(
            "Parent Mobile",
            boolPMobile,
            parentMobileController,
            () {
              setState(() {
                boolPMobile = !boolPMobile;
                if (boolPMobile) {
                  // print("Editing Parent Mobile started");
                } else {
                  // print("Editing Parent Mobile ended");
                }
              });
            },
            maxChars: 10,
            isNumber: true,
            iconData: Icons.edit,
          ),
          textFieldWidget(
            "City",
            boolCity,
            cityNameController,
            () {
              setState(() {
                boolCity = !boolCity;
                if (boolCity) {
                  // print("Editing City started");
                } else {
                  // print("Editing City ended");
                }
              });
            },
            iconData: Icons.edit,
          ),
          textFieldWidget(
            "Organization",
            boolOrganization,
            orgNameController,
            () {
              // setState(() {
              //   boolOrganization = !boolOrganization;
              //   if (boolOrganization) {
              //     print("Editing Organization started");
              //   } else {
              //     print("Editing Organization ended");
              //   }
              // });
            },
            iconData: Icons.lock,
          ),
          textFieldWidget(
            "Batch",
            boolOrganization,
            batchNameController,
            () {
              // setState(() {
              //   boolOrganization = !boolOrganization;
              //   if (boolOrganization) {
              //     print("Editing Organization started");
              //   } else {
              //     print("Editing Organization ended");
              //   }
              // });
            },
            iconData: Icons.lock,
          ),
          updateUserInfoButton(),
        ],
      ),
    );
  }

  Widget textFieldWidget(
    String labelName,
    bool boolEdited,
    TextEditingController textController,
    VoidCallback onPressed, {
    int maxChars = 30,
    bool isNumber = false,
    IconData? iconData,
  }) {
    Icon? icon; // Declare icon as nullable

    // Conditional icon assignment
    if (boolEdited) {
      icon = Icon(iconData);
    } else if (iconData != null) {
      icon = Icon(iconData);
    }

    return Container(
      // color: Colors.green,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelName,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: boolEdited
                      ? TextField(
                          controller: textController,
                          maxLength: maxChars,
                          keyboardType: isNumber
                              ? TextInputType.number
                              : TextInputType.text,
                          inputFormatters: isNumber
                              ? <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]
                              : null,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Enter your text here',
                              counterText: ''),
                        )
                      : TextField(
                          controller: textController,
                          enabled: false,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Enter your text here',
                          ),
                        )),
              IconButton(
                icon: icon ?? Icon(Icons.edit),
                color: Colors.black38,
                onPressed: () {
                  if (textController.text.isEmpty) {
                    // Controller is empty
                    // print("this is not ok");
                    onPressed();
                  } else {
                    onPressed();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget UserDetailsContainer(String? ProfileImage) {
    Stack getUserProfileImage() {
      bool isimagepresent = ProfileImage == " ";

      PopupMenuButton showPopupMenu() {
        SampleItemTwo? selectedMenu;
        SizedBox useroptionsSizedBox(
            String optionText, SampleItemTwo optionselected) {
          bool istrue = optionselected == SampleItemTwo.itemOne;
          return SizedBox(
            width: 140,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(istrue ? Icons.edit_outlined : Icons.delete),
                const SizedBox(
                  width: 5,
                ),
                Text(optionText)
              ],
            ),
          );
        }

        Container iconforpopup() {
          return Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff7654FF),
            ),
            child: const Center(
              child: Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          );
        }

        return PopupMenuButton<SampleItemTwo>(
          icon: iconforpopup(),
          initialValue: selectedMenu,
          iconSize: 18,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          onSelected: (SampleItemTwo item) {
            setState(() {
              selectedMenu = item;
            });
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<SampleItemTwo>>[
            PopupMenuItem<SampleItemTwo>(
              value: SampleItemTwo.itemOne,
              child: useroptionsSizedBox("Edit profile", SampleItemTwo.itemOne),
              onTap: () {
                _onImageButtonPressed(context);
              },
            ),
            PopupMenuItem<SampleItemTwo>(
              value: SampleItemTwo.itemTwo,
              child:
                  useroptionsSizedBox("Remove profile", SampleItemTwo.itemTwo),
              onTap: () {
                _selectedImageFile = null;
                dataImage = Uint8List(0);
              },
            ),
          ],
        );
      }

      return Stack(
        children: [
          _selectedImageFile != null
              ? ClipOval(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff7654FF),
                        width: 3,
                      ),
                    ),
                    child: Image.file(
                      File(_selectedImageFile!.path),
                      width: 106,
                      height: 106,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipOval(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff7654FF),
                        width: 3,
                      ),
                    ),
                    child: isimagepresent
                        ? const Icon(Icons.person)
                        : Image.memory(
                            // base64Decode(ProfileImage ?? ''),
                            dataImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                  ),
                ),
          Positioned(
            bottom: 1,
            right: -8,
            child: showPopupMenu(),
          ),
        ],
      );
    }

    return getUserProfileImage();
  }

  Widget thirdContainerPassword() {
    void changePasswordMethod(context) async {
      String currentPassword = currentPasswordController.text;
      String newPassword = newPasswordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (currentPassword.isEmpty) {
        // showDailogAlert(context, "Current password is incorrect.");
        EasyLoading.showError('Current password is empty');
      } else if (newPassword.isEmpty || confirmPassword.isEmpty) {
        // showDailogAlert(context, "New password and confirm password fields cannot be empty.");
        EasyLoading.showError(
            'New password and confirm password fields cannot be empty.');
      } else if (newPassword != confirmPassword) {
        // showDailogAlert(context, "New password and confirm password do not match.");
        EasyLoading.showError(
            'New password and confirm password do not match.');
      } else if (newPassword == currentPassword) {
        // showDailogAlert(context, "New password cannot be the same as the current password.");
        EasyLoading.showError(
            'New password cannot be the same as the current password.');
      } else {
        // Call the changePassword function
        String data = await ref.read(userProvider).changePassword(
            studentEmailController.text, currentPassword, newPassword);

        if (data == "Password changed successfully") {
          EasyLoading.showSuccess(data);
        } else {
          EasyLoading.showError(data);
        }
        // showDailogAlert(context, data);
      }
    }

    Column textFiledColumn() {
      return Column(
        children: [
          textFieldWidget(
            "Current Password",
            boolCurrentPass,
            currentPasswordController,
            () {
              // setState(() {
              //   boolCurrentPass = !boolCurrentPass;
              //   if (boolCurrentPass) {
              //     print("Editing Student Name started");
              //   } else {
              //     print("Editing Student Name ended");
              //   }
              // });
            },
            iconData: Icons.password,
          ),
          textFieldWidget(
            "New Password",
            boolNewPass,
            newPasswordController,
            () {
              // setState(() {
              //   boolNewPass = !boolNewPass;
              //   if (boolNewPass) {
              //     print("Editing Student Name started");
              //   } else {
              //     print("Editing Student Name ended");
              //   }
              // });
            },
            iconData: Icons.password,
          ),
          textFieldWidget(
            "Confirm Password",
            boolConfirmPass,
            confirmPasswordController,
            () {
              // setState(() {
              //   boolConfirmPass = !boolConfirmPass;
              //   if (boolConfirmPass) {
              //     print("Editing Student Name started");
              //   } else {
              //     print("Editing Student Name ended");
              //   }
              // });
            },
            iconData: Icons.password,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    changePasswordMethod(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1c5e20),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  child: Text("Save Password"),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    changePassword = !changePassword;
                  });
                },
                child: Text("Change password"),
              ),
            ),
          ],
        ),
        changePassword ? Container() : textFiledColumn(),
      ],
    );
  }
}

enum SampleItemTwo {
  itemOne,
  itemTwo,
}
