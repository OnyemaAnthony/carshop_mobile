import 'package:carshop_clientsdk/carshop_clientsdk.dart';

class CarshopSDK {
  static CarshopSDK? _instance;

  late final CarshopClientSdk client;

  factory CarshopSDK() {
    if (_instance == null) {
      _instance = CarshopSDK._();
      _instance!.init();
    }
    return _instance!;
  }

  CarshopSDK._();

  void init() {
    client = CarshopClientSdk.create(
        baseUrl: Uri.parse('http://carshop-dev.uaenorth.cloudapp.azure.com/'));
  }
}
