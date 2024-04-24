// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jeeni/models/onganization_vo.dart';
import 'package:jeeni/providers/auth_provider.dart';

class Student {
  String? name;
  String? lastName;
  String? mobileNumber;
  String? parentName;
  String? parentMobileNumber;
  int? mobileVerificationCode;
  int? parentMobileVerificationCode;
  bool? mobileAuthentication;
  bool? parentMobileAuthentication;
  String? collegeName;
  String? city;
  String? state;
  String? parentEmail;
  int? profileCompletion;
  String? jauth;
  int? attemptedTestCount;
  String? loginId;
  bool? passwordAutoGenerated;
  bool? isValidMobileNumber;
  bool? isValidEmail;
  int? rollNo;
  int? batchId;
  int? id;
  String? email;
  int? role;
  String? password;
  bool? encrypted;
  bool? deleted;
  int? lastAccessTime;
  List<OrganizationVo> organizationVos = [];
  List<int> hideFunctionalityIds = [];
  bool? isOnPrem;
  String? gender;
  String? institute;
  List<int> image = [];
  String? mobileProfileImage;
  String? batchName;
  AuthenticationState authenticationState = AuthenticationState.loading;

  Student({
    this.name,
    this.lastName,
    this.mobileNumber,
    this.parentName,
    this.parentMobileNumber,
    this.mobileVerificationCode,
    this.parentMobileVerificationCode,
    this.mobileAuthentication,
    this.parentMobileAuthentication,
    this.collegeName,
    this.city,
    this.state,
    this.parentEmail,
    this.profileCompletion,
    this.jauth,
    this.attemptedTestCount,
    this.loginId,
    this.passwordAutoGenerated,
    this.isValidMobileNumber,
    this.isValidEmail,
    this.rollNo,
    this.batchId,
    this.id,
    this.email,
    this.role,
    this.password,
    this.encrypted,
    this.deleted,
    this.lastAccessTime,
    required this.organizationVos,
    required this.hideFunctionalityIds,
    this.isOnPrem,
    this.gender,
    this.institute,
    required this.image,
    this.mobileProfileImage,
    this.batchName,
    required this.authenticationState,
  });

  Student copyWith({
    String? name,
    String? lastName,
    String? mobileNumber,
    String? parentName,
    String? parentMobileNumber,
    int? mobileVerificationCode,
    int? parentMobileVerificationCode,
    bool? mobileAuthentication,
    bool? parentMobileAuthentication,
    String? collegeName,
    String? city,
    String? state,
    String? parentEmail,
    int? profileCompletion,
    String? jauth,
    int? attemptedTestCount,
    String? loginId,
    bool? passwordAutoGenerated,
    bool? isValidMobileNumber,
    bool? isValidEmail,
    int? rollNo,
    int? batchId,
    int? id,
    String? email,
    int? role,
    String? password,
    bool? encrypted,
    bool? deleted,
    int? lastAccessTime,
    List<OrganizationVo>? organizationVos,
    List<int>? hideFunctionalityIds,
    bool? isOnPrem,
    String? gender,
    String? institute,
    List<int>? image,
    String? mobileProfileImage,
    String? batchName,
    AuthenticationState? authenticationState,
  }) {
    return Student(
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        parentName: parentName ?? this.parentName,
        parentMobileNumber: parentMobileNumber ?? this.parentMobileNumber,
        mobileVerificationCode:
            mobileVerificationCode ?? this.mobileVerificationCode,
        parentMobileVerificationCode:
            parentMobileVerificationCode ?? this.parentMobileVerificationCode,
        mobileAuthentication: mobileAuthentication ?? this.mobileAuthentication,
        parentMobileAuthentication:
            parentMobileAuthentication ?? this.parentMobileAuthentication,
        collegeName: collegeName ?? this.collegeName,
        city: city ?? this.city,
        state: state ?? this.state,
        parentEmail: parentEmail ?? this.parentEmail,
        profileCompletion: profileCompletion ?? this.profileCompletion,
        jauth: jauth ?? this.jauth,
        attemptedTestCount: attemptedTestCount ?? this.attemptedTestCount,
        loginId: loginId ?? this.loginId,
        passwordAutoGenerated:
            passwordAutoGenerated ?? this.passwordAutoGenerated,
        isValidMobileNumber: isValidMobileNumber ?? this.isValidMobileNumber,
        isValidEmail: isValidEmail ?? this.isValidEmail,
        rollNo: rollNo ?? this.rollNo,
        batchId: batchId ?? this.batchId,
        id: id ?? this.id,
        email: email ?? this.email,
        role: role ?? this.role,
        password: password ?? this.password,
        encrypted: encrypted ?? this.encrypted,
        deleted: deleted ?? this.deleted,
        lastAccessTime: lastAccessTime ?? this.lastAccessTime,
        organizationVos: organizationVos ?? this.organizationVos,
        hideFunctionalityIds: hideFunctionalityIds ?? this.hideFunctionalityIds,
        isOnPrem: isOnPrem ?? this.isOnPrem,
        gender: gender ?? this.gender,
        institute: institute ?? this.institute,
        image: image ?? this.image,
        mobileProfileImage: mobileProfileImage ?? this.mobileProfileImage,
        batchName: batchName ?? this.batchName,
        authenticationState: authenticationState ?? this.authenticationState);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'parentName': parentName,
      'parentMobileNumber': parentMobileNumber,
      'mobileVerificationCode': mobileVerificationCode,
      'parentMobileVerificationCode': parentMobileVerificationCode,
      'mobileAuthentication': mobileAuthentication,
      'parentMobileAuthentication': parentMobileAuthentication,
      'collegeName': collegeName,
      'city': city,
      'state': state,
      'parentEmail': parentEmail,
      'profileCompletion': profileCompletion,
      'jauth': jauth,
      'attemptedTestCount': attemptedTestCount,
      'loginId': loginId,
      'passwordAutoGenerated': passwordAutoGenerated,
      'isValidMobileNumber': isValidMobileNumber,
      'isValidEmail': isValidEmail,
      'rollNo': rollNo,
      'batchId': batchId,
      'id': id,
      'email': email,
      'role': role,
      'password': password,
      'encrypted': encrypted,
      'deleted': deleted,
      'lastAccessTime': lastAccessTime,
      'organizationVos': organizationVos.map((x) => x.toMap()).toList(),
      'hideFunctionalityIds': hideFunctionalityIds,
      'isOnPrem': isOnPrem,
      'gender': gender,
      'institute': institute,
      'image': image,
      'mobileProfileImage': mobileProfileImage,
      'batchName': batchName,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] != null ? map['name'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      mobileNumber:
          map['mobileNumber'] != null ? map['mobileNumber'] as String : null,
      parentName:
          map['parentName'] != null ? map['parentName'] as String : null,
      parentMobileNumber: map['parentMobileNumber'] != null
          ? map['parentMobileNumber'] as String
          : null,
      mobileVerificationCode: map['mobileVerificationCode'] != null
          ? map['mobileVerificationCode'] as int
          : null,
      parentMobileVerificationCode: map['parentMobileVerificationCode'] != null
          ? map['parentMobileVerificationCode'] as int
          : null,
      mobileAuthentication: map['mobileAuthentication'] != null
          ? map['mobileAuthentication'] as bool
          : null,
      parentMobileAuthentication: map['parentMobileAuthentication'] != null
          ? map['parentMobileAuthentication'] as bool
          : null,
      collegeName:
          map['collegeName'] != null ? map['collegeName'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      parentEmail:
          map['parentEmail'] != null ? map['parentEmail'] as String : null,
      profileCompletion: map['profileCompletion'] != null
          ? map['profileCompletion'] as int
          : null,
      jauth: map['jauth'] != null ? map['jauth'] as String : null,
      attemptedTestCount: map['attemptedTestCount'] != null
          ? map['attemptedTestCount'] as int
          : null,
      loginId: map['loginId'] != null ? map['loginId'] as String : null,
      passwordAutoGenerated: map['passwordAutoGenerated'] != null
          ? map['passwordAutoGenerated'] as bool
          : null,
      isValidMobileNumber: map['isValidMobileNumber'] != null
          ? map['isValidMobileNumber'] as bool
          : null,
      isValidEmail:
          map['isValidEmail'] != null ? map['isValidEmail'] as bool : null,
      rollNo: map['rollNo'] != null ? map['rollNo'] as int : null,
      batchId: map['batchId'] != null ? map['batchId'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      password: map['password'] != null ? map['password'] as String : null,
      encrypted: map['encrypted'] != null ? map['encrypted'] as bool : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      lastAccessTime:
          map['lastAccessTime'] != null ? map['lastAccessTime'] as int : null,
      organizationVos: [],
      // organizationVos: List<OrganizationVo>.from(
      //   (map['organizationVos'] as List<int>).map<OrganizationVo>(
      //     (x) => OrganizationVo.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      hideFunctionalityIds: [],
      // hideFunctionalityIds:
      //     List<int>.from((map['hideFunctionalityIds'] as List<int>)),
      isOnPrem: map['isOnPrem'] != null ? map['isOnPrem'] as bool : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      institute: map['institute'] != null ? map['institute'] as String : null,
      // image: List<int>.from((map['image'] as List<int>)),
      image: [],
      mobileProfileImage: map['mobileProfileImage'] != null
          ? map['mobileProfileImage'] as String
          : null,
      batchName: map['batchName'] != null ? map['batchName'] as String : null,
      authenticationState: map["authenticationState"] != null
          ? map["attemptedTestCount"] as AuthenticationState
          : AuthenticationState.loggedOut,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  static Student init({required AuthenticationState authenticationState}) {
    return Student(
      organizationVos: [],
      hideFunctionalityIds: [],
      image: [],
      authenticationState: authenticationState,
    );
  }
}