// To parse this JSON data, do
//
//     final categoricModel = categoricModelFromJson(jsonString);

import 'dart:convert';

CategoricModel categoricModelFromJson(String str) => CategoricModel.fromJson(json.decode(str));

String categoricModelToJson(CategoricModel data) => json.encode(data.toJson());

class CategoricModel {
  CategoricModel({
    this.error,
    this.msg,
  });

  int? error;
  List<CateGoryMsg>? msg;

  factory CategoricModel.fromJson(Map<String, dynamic> json) => CategoricModel(
    error: json["error"],
    msg: json["msg"] == null ? [] : List<CateGoryMsg>.from(json["msg"]!.map((x) => CateGoryMsg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg == null ? [] : List<dynamic>.from(msg!.map((x) => x.toJson())),
  };
}

class CateGoryMsg {
  CateGoryMsg({
    this.catId,
    this.catName,
    this.catNameUrl,
    this.image,
    this.status,
    this.createdAt,
  });

  String? catId;
  String? catName;
  String? catNameUrl;
  String? image;
  String? status;
  String? createdAt;

  factory CateGoryMsg.fromJson(Map<String, dynamic> json) => CateGoryMsg(
    catId: json["cat_id"],
    catName: json["cat_name"],
    catNameUrl: json["cat_name_url"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
    "cat_name_url": catNameUrl,
    "image": image,
    "status": status,
    "created_at": createdAt,
  };
}
