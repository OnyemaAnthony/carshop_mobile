import 'package:carshop_mobile/screens/create_delivery_post_screen.dart';
import 'package:carshop_mobile/screens/create_post_screen.dart';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                    child: const Text('Delivery Post'),
                    onPressed: () async {
                      Services()
                          .getUserCoordination()
                          .then((location) => UiUtilities.push(
                        context,
                        CreateDeliveryPostScreen(
                          //   currLocation: location,
                        ),
                      ));
                    }),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text('Normal Post'),
                  onPressed: () =>
                      UiUtilities.push(context, CreatePostScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
