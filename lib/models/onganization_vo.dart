// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrganizationVo {
  int id;
  String name;
  bool active;
  int adminId;
  String admin;
  String wifiAccessPointName;
  String wifiPassword;
  Set<int> courseIds;
  String loginIdLabel;
  String inetAddress;

  OrganizationVo({
    required this.id,
    required this.name,
    required this.active,
    required this.adminId,
    required this.admin,
    required this.wifiAccessPointName,
    required this.wifiPassword,
    required this.courseIds,
    required this.loginIdLabel,
    required this.inetAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'active': active,
      'adminId': adminId,
      'admin': admin,
      'wifiAccessPointName': wifiAccessPointName,
      'wifiPassword': wifiPassword,
      'courseIds': courseIds.toList(),
      'loginIdLabel': loginIdLabel,
      'inetAddress': inetAddress,
    };
  }

  factory OrganizationVo.fromMap(Map<String, dynamic> map) {
    return OrganizationVo(
      id: map['id'] as int,
      name: map['name'] as String,
      active: map['active'] as bool,
      adminId: map['adminId'] as int,
      admin: map['admin'] as String,
      wifiAccessPointName: map['wifiAccessPointName'] as String,
      wifiPassword: map['wifiPassword'] as String,
      courseIds: Set<int>.from((map['courseIds'] as Set<int>)),
      loginIdLabel: map['loginIdLabel'] as String,
      inetAddress: map['inetAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationVo.fromJson(String source) =>
      OrganizationVo.fromMap(json.decode(source) as Map<String, dynamic>);
}
