class UserRequest {
  String? id;
  String? firstName;
  String? lastName;
  String? sensitiveInfo;
  DateTime? createdAt;
  String? code;

  UserRequest({
     this.id,
     this.firstName,
     this.lastName,
     this.sensitiveInfo,
     this.createdAt,
    this.code
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['sensitiveInfo'] = sensitiveInfo;
    data['createdAt'] = createdAt!.toIso8601String();
    return data;
  }


  Map<String, dynamic> toGoogleJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}
