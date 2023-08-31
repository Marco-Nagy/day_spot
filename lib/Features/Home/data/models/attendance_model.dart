/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    required this.date,
    required this.createdAt,
    required this.checkIn,
    required this.id,
    required this.checkOut,
  });

  String date;
  String createdAt;
  String checkIn;
  String id;
  String checkOut;

  factory AttendanceModel.fromJson(Map<dynamic, dynamic> json) =>
      AttendanceModel(
        date: json["date"] != null ? json["date"].toString() : '',
        createdAt: json["createdAt"]!= null ? json["createdAt"].toString() : '',
        checkIn: json["checkIn"]!= null ? json["checkIn"].toString() : '',
        id: json["id"]!= null ? json["id"].toString() : '',
        checkOut: json["checkOut"]!= null ? json["checkOut"].toString() : '',
      );

  Map<dynamic, dynamic> toJson() => {
        "date": date,
        "createdAt": createdAt,
        "checkIn": checkIn,
        "id": id,
        "checkOut": checkOut,
      };
}
