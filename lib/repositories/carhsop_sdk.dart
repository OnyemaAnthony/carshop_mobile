import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';

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

  void init() async {
    client = CarshopClientSdk.create(
        baseUrl: Uri.parse('http://192.168.1.44:8080'),
        interceptors: [
          (Request request) async => request.copyWith(headers: {
                'Accept': "application/json",
                'Content-type': "application/json",
                'Authorization':
                    'Bearer ${await LocalStorage.getString('access_token')}',
              }),
        ]);
  }
}
