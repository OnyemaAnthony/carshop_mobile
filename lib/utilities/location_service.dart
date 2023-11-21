import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationService {
  static Future<Position?> getLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      bool locationOpened = await Location().requestService();
      if (!locationOpened) {
        return null;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
