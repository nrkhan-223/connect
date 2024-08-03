
// To parse this JSON data, do
//
//     final membershipModel = membershipModelFromJson(jsonString);

import 'dart:convert';

MembershipModel membershipModelFromJson(String str) => MembershipModel.fromJson(json.decode(str));

String membershipModelToJson(MembershipModel data) => json.encode(data.toJson());

class MembershipModel {
  MembershipModel({
    this.error,
    this.msg,
  });

  int? error;
  List<Msg>? msg;

  factory MembershipModel.fromJson(Map<String, dynamic> json) => MembershipModel(
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
    this.packageId,
    this.title,
    this.price,
    this.details,
    this.privilege,
    this.status,
  });

  String? packageId;
  String? title;
  String? price;
  String? details;
  Privilege? privilege;
  String? status;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    packageId: json["package_id"],
    title: json["title"],
    price: json["price"],
    details: json["details"],
    privilege: json["privilege"] == null ? null : Privilege.fromJson(json["privilege"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "package_id": packageId,
    "title": title,
    "price": price,
    "details": details,
    "privilege": privilege?.toJson(),
    "status": status,
  };
}

class Privilege {
  Privilege({
    this.postLimit,
    this.applyLimit,
    this.phone,
    this.category,
  });

  int? postLimit;
  int? applyLimit;
  int? phone;
  int? category;

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
    postLimit: json["post_limit"],
    applyLimit: json["apply_limit"],
    phone: json["phone"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "post_limit": postLimit,
    "apply_limit": applyLimit,
    "phone": phone,
    "category": category,
  };
}
