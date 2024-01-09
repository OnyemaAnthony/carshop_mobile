import 'package:carshop_mobile/utilities/api_keys.dart';

///flutter run --flavor staging -t lib/main_staging.dart
enum Flavor {
  prod,
  dev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get appUrl {
    switch (appFlavor) {
      case Flavor.prod:
        return ApiKeys.serverURL;
      case Flavor.dev:
        return ApiKeys.localHostURL;
      default:
        return ApiKeys.serverURL;
    }
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'Dayno';
      case Flavor.dev:
        return 'Dayno-dev';
      default:
        return 'Dayno';
    }
  }
}
