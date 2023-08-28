/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.employeeId,
    required this.id,
    required this.department,
    required this.email,
  });

  String name;
  String employeeId;
  String id;
  String department;
  String email;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        name: json["name"] != null ? json["name"].toString() : '',
        employeeId:
            json["employeeId"] != null ? json["employeeId"].toString() : '',
        id: json["id"] != null ? json["id"].toString() : '',
        department:
            json["department"] != null ? json["department"].toString() : '',
        email: json["email"] != null ? json["email"].toString() : '',
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "employeeId": employeeId,
        "id": id,
        "department": department,
        "email": email,
      };
}
