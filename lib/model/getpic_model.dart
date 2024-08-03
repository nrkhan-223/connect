class Getprofile {
  Getprofile({
    required this.userData,
    required this.membership,
  });
  late final UserData userData;
  late final Membership membership;

  Getprofile.fromJson(Map<String, dynamic> json){
    userData = UserData.fromJson(json['user_data']);
    membership = Membership.fromJson(json['membership']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_data'] = userData.toJson();
    _data['membership'] = membership.toJson();
    return _data;
  }
}

class UserData {
  UserData({
    required this.userId,
    required this.fullName,
    required this.companyName,
    required this.phone,
    required this.email,
    this.userName,
    required this.password,
    this.typeReg,
    required this.serviceArea,
    required this.status,
    required this.createdAt,
    required this.pic,
    required this.nidStatus,
    required this.nidFront,
    required this.nidBack,
    this.address,
    required this.verifiedMember,
    required this.profileTagline,
    this.nidName,
    this.favorite,
  });
  late final String userId;
  late final String fullName;
  late final String companyName;
  late final String phone;
  late final String email;
  late final Null userName;
  late final String password;
  late final Null typeReg;
  late final List<String> serviceArea;
  late final String status;
  late final String createdAt;
  late final String pic;
  late final String nidStatus;
  late final String nidFront;
  late final String nidBack;
  late final Null address;
  late final String verifiedMember;
  late final String profileTagline;
  late final Null nidName;
  late final Null favorite;

  UserData.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    phone = json['phone'];
    email = json['email'];
    userName = null;
    password = json['password'];
    typeReg = null;
    serviceArea = List.castFrom<dynamic, String>(json['service_area']);
    status = json['status'];
    createdAt = json['created_at'];
    pic = json['pic'];
    nidStatus = json['nid_status'];
    nidFront = json['nid_front'];
    nidBack = json['nid_back'];
    address = null;
    verifiedMember = json['verified_member'];
    profileTagline = json['profile_tagline'];
    nidName = null;
    favorite = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['full_name'] = fullName;
    _data['company_name'] = companyName;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['user_name'] = userName;
    _data['password'] = password;
    _data['type_reg'] = typeReg;
    _data['service_area'] = serviceArea;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['pic'] = pic;
    _data['nid_status'] = nidStatus;
    _data['nid_front'] = nidFront;
    _data['nid_back'] = nidBack;
    _data['address'] = address;
    _data['verified_member'] = verifiedMember;
    _data['profile_tagline'] = profileTagline;
    _data['nid_name'] = nidName;
    _data['favorite'] = favorite;
    return _data;
  }
}

class Membership {
  Membership({
    required this.membershipId,
    required this.userId,
    required this.packageId,
    required this.packageName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.payHistoryId,
    required this.paymentStatus,
    required this.paymentDetails,
    required this.nextBillDate,
    required this.createdAt,
  });
  late final String membershipId;
  late final String userId;
  late final String packageId;
  late final String packageName;
  late final String startDate;
  late final String endDate;
  late final String status;
  late final String payHistoryId;
  late final String paymentStatus;
  late final String paymentDetails;
  late final String nextBillDate;
  late final String createdAt;

  Membership.fromJson(Map<String, dynamic> json){
    membershipId = json['membership_id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    packageName = json['package_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    payHistoryId = json['pay_history_id'];
    paymentStatus = json['payment_status'];
    paymentDetails = json['payment_details'];
    nextBillDate = json['next_bill_date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['membership_id'] = membershipId;
    _data['user_id'] = userId;
    _data['package_id'] = packageId;
    _data['package_name'] = packageName;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['status'] = status;
    _data['pay_history_id'] = payHistoryId;
    _data['payment_status'] = paymentStatus;
    _data['payment_details'] = paymentDetails;
    _data['next_bill_date'] = nextBillDate;
    _data['created_at'] = createdAt;
    return _data;
  }
}