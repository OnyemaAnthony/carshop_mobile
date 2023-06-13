class CommentResponse {
  String? commentId;
  String? parentId;
  String? ownerId;
  String? content;
  String? contentId;
  String? createdAt;
  int? offset;
  int? limit;
  String? deletedAt;
  Location? location;

  CommentResponse({this.commentId,
    this.parentId,
    this.ownerId,
    this.content,
    this.contentId,
    this.limit,
    this.offset,
    this.createdAt,
    this.deletedAt,
    this.location});

  CommentResponse.fromHistory(Map<String, dynamic> json) {
    commentId = json['commentId'];
    ownerId = json['ownerId'];
    contentId = json['contentId'];
    content = json['content'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
  }

  CommentResponse.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    parentId = json['parentId'];
    ownerId = json['ownerId'];
    content = json['content'];
    contentId = json['contentId'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
  }
  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['limit'] = limit;
   // data['parentId'] = parentId;

    return data;
  }
}



class Location {
  int? lat;
  int? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}
