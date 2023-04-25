class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? sensitiveInfo;
  DateTime? createdAt;
  String? code;

  UserModel({
     this.id,
     this.firstName,
     this.lastName,
     this.sensitiveInfo,
     this.createdAt,
    this.code
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      sensitiveInfo: json['sensitiveInfo'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

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
