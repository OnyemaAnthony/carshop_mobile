import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';

class DeliveryStatusScreen extends StatelessWidget {
  const DeliveryStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UiUtilities.translate(context, "delivery_status")),
      ),
      body: Column(
        children: [
          StreamBuilder<int>(
            stream: Stream.periodic(const Duration(minutes: 1), (i) => i),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                CarshopClientSdk client = CarshopSDK().client;
                client.deliveryPostsMyGet().then((value) {
                  print(value);
                });
              }
              return Center(
                child: Text(
                  'Minutes passed: ${snapshot.data ?? 0}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
