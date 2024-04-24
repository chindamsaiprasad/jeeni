import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeeni/utils/local_data_manager.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isEditing = false;

  TextEditingController studentNameController =
      TextEditingController();
  TextEditingController studentEmailController =
      TextEditingController();
  TextEditingController studentMobileController =
      TextEditingController();
  TextEditingController collegeNameController =
      TextEditingController();
  TextEditingController parentNameController =
      TextEditingController();
  TextEditingController parentEmailController =
      TextEditingController();
  TextEditingController parentMobileController =
      TextEditingController();
  TextEditingController cityNameController =
      TextEditingController();
  TextEditingController orgNameController =
      TextEditingController();

  bool boolName = false;
  bool boolEmail = false;
  bool boolMobile = false;
  bool boolCollege = false;
  bool boolPName = false;
  bool boolPEmail = false;
  bool boolPMobile = false;
  bool boolCity = false;
  bool boolOrganization = false;

  @override
  void initState() {
    // TODO: implement initState
    LocalDataManager().loadStudentFromLocal().then((student) {
      print(student.name);

      setState(() {
        studentNameController.text = '${student.name} ${student.lastName}';
        studentEmailController.text = student.email ?? '';
        studentMobileController.text = student.mobileNumber ?? '';
        collegeNameController.text = student.collegeName ?? '';
        parentNameController.text = student.parentName ?? '';
        parentEmailController.text = student.parentEmail ?? '';
        parentMobileController.text = student.parentMobileNumber ?? '';
        cityNameController.text = student.city ?? '';
        // Check if organizationVos is not empty before accessing its elements
        if (student.organizationVos.isNotEmpty) {
          orgNameController.text = student.organizationVos[0].name ?? '';
        }
      });

    });
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              firstContainer(),
              const SizedBox(height: 20,),
              secondContainer(),
              const SizedBox(height: 60,),
            ],
          ),
        ));
  }

  Widget firstContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black, // Choose color for the border
                width: 2, // Choose width for the border
              ),
            ),
            child: ClipOval(
              child: Image.network(
                "https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png",
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                  print("Editing Student Name started");
                } else {
                  print("Editing Student Name ended");
                }
              });
            },
          ),
          textFieldWidget(
            "Student Email",
            boolEmail,
            studentEmailController,
            () {
              setState(() {
                boolEmail = !boolEmail;
                if (boolEmail) {
                  print("Editing Student Email started");
                } else {
                  print("Editing Student Email ended");
                }
              });
            },
          ),
          textFieldWidget(
            "Student Mobile",
            boolMobile,
            studentMobileController,
            () {
              setState(() {
                boolMobile = !boolMobile;
                if (boolMobile) {
                  print("Editing Student Mobile started");
                } else {
                  print("Editing Student Mobile ended");
                }
              });
            },
            maxChars: 10,
            isNumber: true,
          ),
          textFieldWidget(
            "College",
            boolCollege,
            collegeNameController,
            () {
              setState(() {
                boolCollege = !boolCollege;
                if (boolCollege) {
                  print("Editing College started");
                } else {
                  print("Editing College ended");
                }
              });
            },
          ),
          textFieldWidget(
            "Parent Name",
            boolPName,
            parentNameController,
            () {
              setState(() {
                boolPName = !boolPName;
                if (boolPName) {
                  print("Editing Parent Name started");
                } else {
                  print("Editing Parent Name ended");
                }
              });
            },
          ),
          textFieldWidget(
            "Parent Email",
            boolPEmail,
            parentEmailController,
            () {
              setState(() {
                boolPEmail = !boolPEmail;
                if (boolPEmail) {
                  print("Editing Parent Email started");
                } else {
                  print("Editing Parent Email ended");
                }
              });
            },
          ),
          textFieldWidget(
            "Parent Mobile",
            boolPMobile,
            parentMobileController,
            () {
              setState(() {
                boolPMobile = !boolPMobile;
                if (boolPMobile) {
                  print("Editing Parent Mobile started");
                } else {
                  print("Editing Parent Mobile ended");
                }
              });
            },
            maxChars: 10,
            isNumber: true,
          ),
          textFieldWidget(
            "City",
            boolCity,
            cityNameController,
            () {
              setState(() {
                boolCity = !boolCity;
                if (boolCity) {
                  print("Editing City started");
                } else {
                  print("Editing City ended");
                }
              });
            },
          ),
          textFieldWidget(
            "Organization",
            boolOrganization,
            orgNameController,
            () {
              setState(() {
                boolOrganization = !boolOrganization;
                if (boolOrganization) {
                  print("Editing Organization started");
                } else {
                  print("Editing Organization ended");
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget textFieldWidget(String labelName, bool boolEdited,
      TextEditingController textController, VoidCallback onPressed,
      {int maxChars = 20, bool isNumber = false}) {
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
                icon: Icon(boolEdited ? Icons.save : Icons.edit),
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
}
