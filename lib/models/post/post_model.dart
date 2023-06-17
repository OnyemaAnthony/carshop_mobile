class PostModel {
  String? title;
  String? content;
  double? lat;
  double? long;
  String? postId;


  PostModel({this.title, this.content, this.lat, this.long});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'],
      content: json['content'],
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'lat': lat,
      'long': long,
    };
  }
}
