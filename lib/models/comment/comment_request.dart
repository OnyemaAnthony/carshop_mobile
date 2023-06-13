class CommentRequest {
  String? parentId;
  String? content;
  Location? location;

  CommentRequest({this.parentId, this.content, this.location});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['content'] = content;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  int? lat;
  int? lng;

  Location({this.lat, this.lng});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
