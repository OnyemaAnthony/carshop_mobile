class DeliveryPost {
  String? id;
  String productName;
  num reward;
  DateTime startDate;
  DateTime endDate;
  Coordination destination;
  Coordination startLocation;


  DeliveryPost({
    required this.productName,
    required this.reward,
    required this.startDate,
    required this.endDate,
    required this.destination,
    required this.startLocation,
  });

  factory DeliveryPost.fromJson(Map<String, dynamic> json) {
    return DeliveryPost(
      productName: json['productName'],
      reward: json['reward'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      destination: Coordination.fromJson(json['destination']),
      startLocation: Coordination.fromJson(json['startLocation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'reward': reward,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'destination': destination.toJson(),
      'startLocation': startLocation.toJson(),
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