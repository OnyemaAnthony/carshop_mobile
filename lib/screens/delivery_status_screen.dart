import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:flutter/material.dart';

import '../repositories/carhsop_sdk.dart';

class DeliveryStatusScreen extends StatelessWidget {
  const DeliveryStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("delivery_status".trans(context)),
      ),
      body: Column(
        children: [
          StreamBuilder<int>(
            stream: Stream.periodic(const Duration(minutes: 1), (i) => i),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                CarshopClientSdk client = CarshopSDK().client;
                client.deliveryPostsMyGet().then((value) {});
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
