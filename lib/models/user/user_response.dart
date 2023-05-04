class UserResponse {
  Data? data;

  UserResponse({this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Auth? auth;
  UserModel? user;

  Data({this.auth, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (auth != null) {
      data['auth'] = auth!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Auth {
  String? expiresAt;
  String? accessToken;

  Auth({this.expiresAt, this.accessToken});

  Auth.fromJson(Map<String, dynamic> json) {
    expiresAt = json['expiresAt'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiresAt'] = expiresAt;
    data['accessToken'] = accessToken;
    return data;
  }
}

class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? createdAt;

  UserModel({this.id, this.email, this.firstName, this.lastName, this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['createdAt'] = createdAt;
    return data;
  }
}
