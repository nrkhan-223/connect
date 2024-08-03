class MyApply {
  MyApply({
    required this.applyId,
    required this.jobId,
    required this.jobTitle,
    required this.ownerId,
    required this.userId,
    required this.time,
    required this.price,
    required this.doc,
    required this.note,
    required this.status,
    required this.isChecked,
    required this.createdAt,
  });
  late final String applyId;
  late final String jobId;
  late final String jobTitle;
  late final String ownerId;
  late final String userId;
  late final String time;
  late final String price;
  late final Doc doc;
  late final String note;
  late final String status;
  late final String isChecked;
  late final String createdAt;

  MyApply.fromJson(Map<String, dynamic> json){
    applyId = json['apply_id'];
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    ownerId = json['owner_id'];
    userId = json['user_id'];
    time = json['time'];
    price = json['price'];
    doc = Doc.fromJson(json['doc']);
    note = json['note'];
    status = json['status'];
    isChecked = json['is_checked'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['apply_id'] = applyId;
    _data['job_id'] = jobId;
    _data['job_title'] = jobTitle;
    _data['owner_id'] = ownerId;
    _data['user_id'] = userId;
    _data['time'] = time;
    _data['price'] = price;
    _data['doc'] = doc.toJson();
    _data['note'] = note;
    _data['status'] = status;
    _data['is_checked'] = isChecked;
    _data['created_at'] = createdAt;
    return _data;
  }
}

class Doc {
  Doc({
    required this.image,
    required this.audio,
    required this.video,
    // required this.document,
  });
  late final List<String> image;
  late final List<String> audio;
  late final List<String> video;
  // late final List<String> document;

  Doc.fromJson(Map<String, dynamic> json){
    image = List.castFrom<dynamic, String>(json['image']);
    audio = List.castFrom<dynamic, String>(json['audio']);
    video = List.castFrom<dynamic, String>(json['video']);
    // document = List.castFrom<dynamic, String>(json['document']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['audio'] = audio;
    _data['video'] = video;
    // _data['document'] = document;
    return _data;
  }
}