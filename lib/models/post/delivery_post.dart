import 'package:carshop_mobile/models/post/post_model.dart';

class DeliveryPost extends PostModel {
  String? id;
  String productName;
  num reward;
  DateTime startDate;
  DateTime endDate;
  Coordination destination;
  Coordination? startLocation;

  DeliveryPost({
    required title,
    required content,
    required this.productName,
    required this.reward,
    required this.startDate,
    required this.endDate,
    required this.destination,
    this.startLocation,
  }) : super(title: title, content: content);

  factory DeliveryPost.fromJson(Map<String, dynamic> json) {
    return DeliveryPost(
      productName: json['productName'],
      reward: json['reward'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      destination: Coordination.fromJson(json['destination']),
      startLocation: Coordination.fromJson(json['startLocation']),
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'reward': reward,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'destination': destination.toJson(),
      'startLocation': startLocation!.toJson(),
      'title': title,
      'content': content,
    };
  }
}

class Coordination {
  double latitude;
  double longitude;

  Coordination({required this.latitude, required this.longitude});

  factory Coordination.fromJson(Map<String, dynamic> json) {
    return Coordination(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
