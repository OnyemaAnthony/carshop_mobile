import 'package:carshop_mobile/blocs/setting/setting_bloc.dart';
import 'package:carshop_mobile/screens/change_language_screen.dart';
import 'package:carshop_mobile/widgets/icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';
import '../utilities/constants.dart';
import '../utilities/ui_utilities.dart';
import '../widgets/image_to_icon.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  late SettingBloc settingBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            UiUtilities.pop(context);
          },
          child: const ImageToIcon(
            imagePath: Constants.lessThanArrowIconPath,
          ),
        ),
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          settingBloc = BlocProvider.of<SettingBloc>(context);
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      UiUtilities.pushNavBar(
                          context, ChangeLanguageScreen(), true);
                    },
                    child: ListTile(
                      leading:
                          const IconTile(iconPath: Constants.activityIconPath),
                      title: Text(
                        "Change language",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: const ImageToIcon(
                        color: Colors.black,
                        imagePath: Constants.greaterThanArrowIconPath,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile.adaptive(
                      inactiveTrackColor: Colors.grey,
                      title: Text(
                        "Mute Notifications",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: false,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile.adaptive(
                      title: Text(
                        state.isDarkTheme
                            ? "Change to Light"
                            : "Change to Dark",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: state.isDarkTheme,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (value) {
                        settingBloc.add(ChangeThemeEvent(value));
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(SignOutEventTest());
                    },
                    child: ListTile(
                      leading:
                          const IconTile(iconPath: Constants.logoutIconPath),
                      title: Text(
                        "Delete Account",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
