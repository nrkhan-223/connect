// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.error,
    this.msg,
  });

  int? error;
  List<Msg>? msg;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.id,
    this.receiverId,
    this.senderId,
    this.jobId,
    this.type,
    this.content,
    this.status,
    this.createdAt,
  });

  String? id;
  String? receiverId;
  String? senderId;
  String? jobId;
  String? type;
  String? content;
  String? status;
  DateTime? createdAt;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    id: json["id"],
    receiverId: json["receiver_id"],
    senderId: json["sender_id"],
    jobId: json["job_id"],
    type: json["type"],
    content: json["content"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiver_id": receiverId,
    "sender_id": senderId,
    "job_id": jobId,
    "type": type,
    "content": content,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
  };
}
