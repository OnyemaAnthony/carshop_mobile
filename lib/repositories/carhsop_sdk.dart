import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';

import '../flavours_config.dart';

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
    client =
        CarshopClientSdk.create(baseUrl: Uri.parse(F.appUrl), interceptors: [
      (Request request) async => request.copyWith(headers: {
            'Accept': "application/json",
            'Content-type': "application/json",
            'Authorization':
                'Bearer ${await LocalStorage.getString('access_token')}',
          }),
    ]);
  }
}
