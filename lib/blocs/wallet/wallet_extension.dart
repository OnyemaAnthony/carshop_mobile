import 'package:carshop_clientsdk/carshop_clientsdk.dart';

extension WalletExtension on WalletDescriptor {
  String get getBalance => ((balance?.value ?? 0) / 100).toString();
}
