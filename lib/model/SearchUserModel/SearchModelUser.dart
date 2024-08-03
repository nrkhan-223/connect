

// To parse this JSON data, do
//
//     final searchUserModel = searchUserModelFromJson(jsonString);

import 'dart:convert';

SearchUserModel searchUserModelFromJson(String str) => SearchUserModel.fromJson(json.decode(str));

String searchUserModelToJson(SearchUserModel data) => json.encode(data.toJson());

class SearchUserModel {
  SearchUserModel({
    this.error,
    this.type,
    this.msg,
  });

  int? error;
  String? type;
  List<Map<String, String?>>? msg;

  factory SearchUserModel.fromJson(Map<String, dynamic> json) => SearchUserModel(
    error: json["error"],
    type: json["type"],
    msg: json["msg"] == null ? [] : List<Map<String, String?>>.from(json["msg"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "type": type,
    "msg": msg == null ? [] : List<dynamic>.from(msg!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
