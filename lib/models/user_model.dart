class UserModel {
  String id;
  String firstName;
  String lastName;
  String sensitiveInfo;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.sensitiveInfo,
    required this.createdAt,
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['sensitiveInfo'] = this.sensitiveInfo;
    data['createdAt'] = this.createdAt.toIso8601String();
    return data;
  }
}
