class PostModel {
  String? title;
  String? content;
  String? postId;
  PostLocation? location;

  PostModel({this.title, this.content, this.location});

  PostModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    location = json['location'] != null
        ? PostLocation.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['content'] = content;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class PostLocation {
  num? lat;
  num? lng;

  PostLocation({this.lat, this.lng});

  PostLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
