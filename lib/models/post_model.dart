class PostModel {
  String postId;
  String ownerId;
  String latestContentId;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Coordination location;

  PostModel({
    required this.postId,
    required this.ownerId,
    required this.latestContentId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.location,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      ownerId: json['ownerId'],
      latestContentId: json['latestContentId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
      location: Coordination.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['latestContentId'] = this.latestContentId;
    data['createdAt'] = this.createdAt.toIso8601String();
    if (this.updatedAt != null) {
      data['updatedAt'] = this.updatedAt!.toIso8601String();
    }
    if (this.deletedAt != null) {
      data['deletedAt'] = this.deletedAt!.toIso8601String();
    }
    data['location'] = this.location.toJson();
    return data;
  }
}

class Coordination {
  double lat;
  double lng;

  Coordination({
    required this.lat,
    required this.lng,
  });

  factory Coordination.fromJson(Map<String, dynamic> json) {
    return Coordination(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
