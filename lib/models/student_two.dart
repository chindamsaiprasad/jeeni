class StudentModelClassTwo {
  StudentModelClassTwo({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.password,
    required this.encrypted,
    required this.deleted,
    required this.lastAccessTime,
    required this.questionPaperVos,
    required this.hideFunctionalityIds,
    required this.jauth,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.mobileNumber,
    required this.parentName,
    required this.parentMobileNumber,
    required this.mobileVerificationCode,
    required this.parentMobileVerificationCode,
    required this.mobileAuthentication,
    required this.parentMobileAuthentication,
    required this.collegeName,
    required this.institute,
    required this.city,
    required this.state,
    required this.parentEmail,
    required this.profileCompletion,
    required this.orgName,
    required this.batchName,
    required this.attemptedTestCount,
    required this.loginId,
    required this.category,
    required this.passwordAutoGenerated,
    required this.organizationVos,
    required this.rollNo,
    required this.batchId,
    required this.syncStatus,
    required this.mobileProfileImage,
    required this.userId,
    required this.mailLogsVo,
    required this.orgVo,
    required this.deviceList,
    required this.deleteDeviceList,
    required this.validEmail,
    required this.validMobileNumber,
    required this.base64Image,
    required this.onPrem,
  });
  late final int id;
  late final String userName;
  late final String email;
  late final int role;
  late final String password;
  late final bool encrypted;
  late final bool deleted;
  late final int lastAccessTime;
  late final String questionPaperVos;
  late final String hideFunctionalityIds;
  late final String jauth;
  late final String name;
  late final String lastName;
  late final String gender;
  late final String mobileNumber;
  late final String parentName;
  late final String parentMobileNumber;
  late final int mobileVerificationCode;
  late final int parentMobileVerificationCode;
  late final bool mobileAuthentication;
  late final bool parentMobileAuthentication;
  late final String collegeName;
  late final String institute;
  late final String city;
  late final String state;
  late final String parentEmail;
  late final int profileCompletion;
  late final String orgName;
  late final String batchName;
  late final int attemptedTestCount;
  late final String loginId;
  late final String category;
  late final bool passwordAutoGenerated;
  late final List<OrganizationVosTwo> organizationVos;
  late final int rollNo;
  late final int batchId;
  late final int syncStatus;
  late final String mobileProfileImage;
  late final int userId;
  late final String mailLogsVo;
  late final String orgVo;
  late final String deviceList;
  late final String deleteDeviceList;
  late final bool validEmail;
  late final bool validMobileNumber;
  late final String base64Image;
  late final bool onPrem;
  
  // StudentModelClassTwo.fromJson(Map<String, dynamic> json){
  //   id = json['id'];
  //   userName = json['userName'];
  //   email = json['email'];
  //   role = json['role'];
  //   password = json['password'];
  //   encrypted = json['encrypted'];
  //   deleted = json['deleted'];
  //   lastAccessTime = json['lastAccessTime'];
  //   questionPaperVos = json['questionPaperVos'];
  //   hideFunctionalityIds = json['hideFunctionalityIds'];
  //   jauth = json['jauth'];
  //   name = json['name'];
  //   lastName = json['lastName'];
  //   gender = json['gender'];
  //   mobileNumber = json['mobileNumber'];
  //   parentName = json['parentName'];
  //   parentMobileNumber = json['parentMobileNumber'];
  //   mobileVerificationCode = json['mobileVerificationCode'];
  //   parentMobileVerificationCode = json['parentMobileVerificationCode'];
  //   mobileAuthentication = json['mobileAuthentication'];
  //   parentMobileAuthentication = json['parentMobileAuthentication'];
  //   collegeName = json['collegeName'];
  //   institute = json['institute'];
  //   city = json['city'];
  //   state = json['state'];
  //   parentEmail = json['parentEmail'];
  //   profileCompletion = json['profileCompletion'];
  //   orgName = json['orgName'];
  //   batchName = json['batchName'];
  //   attemptedTestCount = json['attemptedTestCount'];
  //   loginId = json['loginId'];
  //   category = json['category'];
  //   passwordAutoGenerated = json['passwordAutoGenerated'];
  //   organizationVos = List.from(json['organizationVos']).map((e)=>OrganizationVosTwo.fromJson(e)).toList();
  //   rollNo = json['rollNo'];
  //   batchId = json['batchId'];
  //   syncStatus = json['syncStatus'];
  //   mobileProfileImage = json['mobileProfileImage'];
  //   userId = json['userId'];
  //   mailLogsVo = json['mailLogsVo'];
  //   orgVo = json['orgVo'];
  //   deviceList = json['deviceList'];
  //   deleteDeviceList = json['deleteDeviceList'];
  //   validEmail = json['validEmail'];
  //   validMobileNumber = json['validMobileNumber'];
  //   base64Image = json['base64Image'];
  //   onPrem = json['onPrem'];
  // }

  StudentModelClassTwo.fromJson(Map<String, dynamic> json){
    id = json['id'];  // 1
    print("1");
    userName = json['userName'] ?? '';  // 2
    print("2");
    email = json['email'];  // 3
    print("3");
    role = json['role'];  // 4
    print("4");
    password = json['password'];  // 5
    print("5");
    encrypted = json['encrypted'];  // 6
    print("6");
    deleted = json['deleted'];  // 7
    print("7");
    lastAccessTime = json['lastAccessTime'];  // 8
    print("8");
    questionPaperVos = json['questionPaperVos'] ?? '';  // 9
    print("9");
    hideFunctionalityIds = json['hideFunctionalityIds'] ?? '';  // 10
    print("10");
    jauth = json['jauth'] ?? '';  // 11
    print("11");
    name = json['name'] ?? '';  // 12
    print("12");
    lastName = json['lastName'] ?? '';  // 13
    print("13");
    gender = json['gender'] ?? '';  // 14
    print("14");
    mobileNumber = json['mobileNumber'];  // 15
    print("15");
    parentName = json['parentName'] ?? '';  // 16
    print("16");
    parentMobileNumber = json['parentMobileNumber'] ?? '';  // 17
    print("17");
    mobileVerificationCode = json['mobileVerificationCode'];  // 18
    print("18");
    parentMobileVerificationCode = json['parentMobileVerificationCode'];  // 19
    print("19");
    mobileAuthentication = json['mobileAuthentication'];  // 20
    print("20");
    parentMobileAuthentication = json['parentMobileAuthentication'];  // 21
    print("21");
    collegeName = json['collegeName'] ?? '';  // 22
    print("22");
    institute = json['institute'] ?? '';  // 23
    print("23");
    city = json['city'] ?? '';  // 24
    print("24");
    state = json['state'] ?? '';  // 25
    print("25");
    parentEmail = json['parentEmail'] ?? '';  // 26
    print("26");
    profileCompletion = json['profileCompletion'];  // 27
    print("27");
    orgName = json['orgName'] ?? '';  // 28
    print("28");
    batchName = json['batchName'];  // 29
    print("29");
    attemptedTestCount = json['attemptedTestCount'];  // 30
    print("30");
    loginId = json['loginId'];  // 31
    print("31");
    category = json['category'];  // 32
    print("32");
    passwordAutoGenerated = json['passwordAutoGenerated'];  // 33
    print("33");
    organizationVos = List.from(json['organizationVos']).map((e)=>OrganizationVosTwo.fromJson(e)).toList();  // 34
    print("34");
    rollNo = json['rollNo'];  // 35
    print("35");
    batchId = json['batchId'];  // 36
    print("36");
    syncStatus = json['syncStatus'];  // 37
    print("37");
    mobileProfileImage = json['mobileProfileImage'] ?? '';  // 38
    print("38");
    userId = json['userId'];  // 39
    print("39");
    mailLogsVo = json['mailLogsVo'] ?? '';  // 40
    print("40");
    orgVo = json['orgVo'] ?? '';  // 41
    print("41");
    deviceList = json['deviceList'] ?? '';  // 42
    print("42");
    deleteDeviceList = json['deleteDeviceList'] ?? '';  // 43
    print("43");
    validEmail = json['validEmail'];  // 44
    print("44");
    validMobileNumber = json['validMobileNumber'];  // 45
    print("45");
    base64Image = json['base64Image'] ?? '';  // 46
    print("46");
    onPrem = json['onPrem'];  // 47
    print("47");
}


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userName'] = userName;
    _data['email'] = email;
    _data['role'] = role;
    _data['password'] = password;
    _data['encrypted'] = encrypted;
    _data['deleted'] = deleted;
    _data['lastAccessTime'] = lastAccessTime;
    _data['questionPaperVos'] = questionPaperVos;
    _data['hideFunctionalityIds'] = hideFunctionalityIds;
    _data['jauth'] = jauth;
    _data['name'] = name;
    _data['lastName'] = lastName;
    _data['gender'] = gender;
    _data['mobileNumber'] = mobileNumber;
    _data['parentName'] = parentName;
    _data['parentMobileNumber'] = parentMobileNumber;
    _data['mobileVerificationCode'] = mobileVerificationCode;
    _data['parentMobileVerificationCode'] = parentMobileVerificationCode;
    _data['mobileAuthentication'] = mobileAuthentication;
    _data['parentMobileAuthentication'] = parentMobileAuthentication;
    _data['collegeName'] = collegeName;
    _data['institute'] = institute;
    _data['city'] = city;
    _data['state'] = state;
    _data['parentEmail'] = parentEmail;
    _data['profileCompletion'] = profileCompletion;
    _data['orgName'] = orgName;
    _data['batchName'] = batchName;
    _data['attemptedTestCount'] = attemptedTestCount;
    _data['loginId'] = loginId;
    _data['category'] = category;
    _data['passwordAutoGenerated'] = passwordAutoGenerated;
    _data['organizationVos'] = organizationVos.map((e)=>e.toJson()).toList();
    _data['rollNo'] = rollNo;
    _data['batchId'] = batchId;
    _data['syncStatus'] = syncStatus;
    _data['mobileProfileImage'] = mobileProfileImage;
    _data['userId'] = userId;
    _data['mailLogsVo'] = mailLogsVo;
    _data['orgVo'] = orgVo;
    _data['deviceList'] = deviceList;
    _data['deleteDeviceList'] = deleteDeviceList;
    _data['validEmail'] = validEmail;
    _data['validMobileNumber'] = validMobileNumber;
    _data['base64Image'] = base64Image;
    _data['onPrem'] = onPrem;
    return _data;
  }
}

class OrganizationVosTwo {
  OrganizationVosTwo({
    required this.id,
    required this.name,
    required this.active,
    required this.adminId,
    required this.admin,
    required this.batches,
    required this.wifiAccessPointName,
    required this.wifiPassword,
    required this.courseIds,
    required this.loginIdLabel,
    required this.inetAddress,
    required this.partialResult,
    required this.apkUrl,
    required this.apkVersion,
    required this.resultVerificationFlag,
    required this.isTestQuestionsDownload,
    required this.isOnPrem,
    required this.noOfDevice,
    required this.isEnrollStudentRollnoWise,
    required this.productId,
  });
  late final int id;
  late final String name;
  late final bool active;
  late final int adminId;
  late final String admin;
  late final String batches;
  late final String wifiAccessPointName;
  late final String wifiPassword;
  late final int courseIds;
  late final String loginIdLabel;
  late final String inetAddress;
  late final bool partialResult;
  late final String apkUrl;
  late final double apkVersion;
  late final bool resultVerificationFlag;
  late final bool isTestQuestionsDownload;
  late final int isOnPrem;
  late final int noOfDevice;
  late final bool isEnrollStudentRollnoWise;
  late final int productId;
  
  OrganizationVosTwo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    active = json['active'];
    adminId = json['adminId'];
    admin = json['admin'] ?? '';
    batches = json['batches'] ?? '';
    wifiAccessPointName = json['wifiAccessPointName'];
    wifiPassword = json['wifiPassword'];
    courseIds = json['courseIds'] ?? 0;
    loginIdLabel = json['loginIdLabel'];
    inetAddress = json['inetAddress'];
    partialResult = json['partialResult'];
    apkUrl = json['apkUrl'] ?? '';
    apkVersion = json['apkVersion'];
    resultVerificationFlag = json['resultVerificationFlag'];
    isTestQuestionsDownload = json['isTestQuestionsDownload'];
    isOnPrem = json['isOnPrem'];
    noOfDevice = json['noOfDevice'];
    isEnrollStudentRollnoWise = json['isEnrollStudentRollnoWise'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['active'] = active;
    _data['adminId'] = adminId;
    _data['admin'] = admin;
    _data['batches'] = batches;
    _data['wifiAccessPointName'] = wifiAccessPointName;
    _data['wifiPassword'] = wifiPassword;
    _data['courseIds'] = courseIds;
    _data['loginIdLabel'] = loginIdLabel;
    _data['inetAddress'] = inetAddress;
    _data['partialResult'] = partialResult;
    _data['apkUrl'] = apkUrl;
    _data['apkVersion'] = apkVersion;
    _data['resultVerificationFlag'] = resultVerificationFlag;
    _data['isTestQuestionsDownload'] = isTestQuestionsDownload;
    _data['isOnPrem'] = isOnPrem;
    _data['noOfDevice'] = noOfDevice;
    _data['isEnrollStudentRollnoWise'] = isEnrollStudentRollnoWise;
    _data['productId'] = productId;
    return _data;
  }
}