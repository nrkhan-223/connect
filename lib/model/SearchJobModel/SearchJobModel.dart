// To parse this JSON data, do
//
//     final searchJobModel = searchJobModelFromJson(jsonString);

import 'dart:convert';

SearchJobModel searchJobModelFromJson(String str) => SearchJobModel.fromJson(json.decode(str));

String searchJobModelToJson(SearchJobModel data) => json.encode(data.toJson());

class SearchJobModel {
  SearchJobModel({
    this.error,
    this.msg,
  });

  int? error;
  List<Msg>? msg;

  factory SearchJobModel.fromJson(Map<String, dynamic> json) => SearchJobModel(
    error: json["error"],
    msg: json["msg"] == null ? [] : List<Msg>.from(json["msg"]!.map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg == null ? [] : List<dynamic>.from(msg!.map((x) => x.toJson())),
  };
}

class Msg {
  Msg({
    this.jobId,
    this.jobTitle,
    this.description,
    this.contactnumber,
    this.category,
    this.createdAt,
    this.status,
    this.createdBy,
    this.doc,
    this.canapply,
    this.createdByName,
    this.sharelink,
  });

  String? jobId;
  String? jobTitle;
  String? description;
  String? contactnumber;
  String? category;
  DateTime? createdAt;
  String? status;
  String? createdBy;
  dynamic doc;
  int? canapply;
  String? createdByName;
  String? sharelink;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    jobId: json["job_id"],
    jobTitle: json["job_title"],
    description: json["description"],
    contactnumber: json["contactnumber"],
    category: json["category"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    status: json["status"],
    createdBy: json["created_by"],
    doc: json["doc"],
    canapply: json["canapply"],
    createdByName: json["created_by_name"],
    sharelink: json["sharelink"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "job_title": jobTitle,
    "description": description,
    "contactnumber": contactnumber,
    "category": category,
    "created_at": createdAt?.toIso8601String(),
    "status": status,
    "created_by": createdBy,
    "doc": doc,
    "canapply": canapply,
    "created_by_name": createdByName,
    "sharelink": sharelink,
  };
}
