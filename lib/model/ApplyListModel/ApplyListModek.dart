

import 'dart:convert';

ApplyListModel applyListModelFromJson(String str) => ApplyListModel.fromJson(json.decode(str));

String applyListModelToJson(ApplyListModel data) => json.encode(data.toJson());

class ApplyListModel {
  int? error;
  List<Msg>? msg;

  ApplyListModel({
    this.error,
    this.msg,
  });

  factory ApplyListModel.fromJson(Map<String, dynamic> json) => ApplyListModel(
    error: json["error"],
    msg: json["msg"] == null ? [] : List<Msg>.from(json["msg"]!.map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg == null ? [] : List<dynamic>.from(msg!.map((x) => x.toJson())),
  };
}

class Msg {
  String? applyId;
  String? jobId;
  String? ownerId;
  String? userId;
  String? time;
  String? price;
  Doc? doc;
  String? note;
  String? status;
  String? isChecked;
  DateTime? createdAt;
  String? applicantName;
  String? applicantPhone;


  Msg({
    this.applyId,
    this.jobId,
    this.ownerId,
    this.userId,
    this.time,
    this.price,
    this.doc,
    this.note,
    this.status,
    this.isChecked,
    this.createdAt,
    this.applicantName,
    this.applicantPhone,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    applyId: json["apply_id"],
    jobId: json["job_id"],
    ownerId: json["owner_id"],
    userId: json["user_id"],
    time: json["time"],
    price: json["price"],
    doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
    note: json["note"],
    status: json["status"],
    isChecked: json["is_checked"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    applicantName: json["applicant_name"],
    applicantPhone: json["applicant_phone"],
  );

  Map<String, dynamic> toJson() => {
    "apply_id": applyId,
    "job_id": jobId,
    "owner_id": ownerId,
    "user_id": userId,
    "time": time,
    "price": price,
    "doc": doc?.toJson(),
    "note": note,
    "status": status,
    "is_checked": isChecked,
    "created_at": createdAt?.toIso8601String(),
    "applicant_name": applicantName,
    "applicant_phone": applicantPhone,
  };
}

class Doc {
  List<dynamic>? image;
  List<String>? audio;
  List<String>? video;

  Doc({
    this.image,
    this.audio,
    this.video,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    image: json["image"] == null ? [] : List<dynamic>.from(json["image"]!.map((x) => x)),
    audio: json["audio"] == null ? [] : List<String>.from(json["audio"]!.map((x) => x)),
    video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
    "audio": audio == null ? [] : List<dynamic>.from(audio!.map((x) => x)),
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
  };
}