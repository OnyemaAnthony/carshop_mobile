import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/shared_widgets/build_elevated_button.dart';
import 'package:carshop_mobile/widgets/shared_widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockAppScreen extends StatelessWidget {
  const BlockAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.screenHeightScale(),
              horizontal: 8.screenWidthScale()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/dev-icon.png',
                height: 110.screenHeightScale(),
                width: 110.screenHeightScale(),
              ),
              30.sizedBox(),
              const BuildText(
                text:
                    'Hello,\n We require your permission to access your location to be able to continue using Our Application. \nif you refused the location permission several times, you will need to allow it from application settings manually',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              30.sizedBox(),
              BuildElevatedButton(
                text: 'Get my Location',
                onPressed: () {
                  UiUtilities.pop(context);
                  context.read<MapBloc>().add(GetCurrentLocationEvent());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
