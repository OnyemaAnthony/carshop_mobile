import 'package:carshop_mobile/blocs/setting/setting_bloc.dart';
import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/utilities/language.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/image_to_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});

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
      body: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) {
          if (context.locale != state.language.locale) {
            context.setLocale(state.language.locale);
          }
        },
        builder: (context, state) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 9 / 7,
              mainAxisExtent: 100,
            ),
            itemBuilder: (context, index) {
              Language currentLanguage = Constants.countriesFlag[index];
              return GestureDetector(
                onTap: () {
                  context
                      .read<SettingBloc>()
                      .add(ChangeLanguageEvent(currentLanguage));
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1.0),
                          color: state.language == currentLanguage
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: state.language == currentLanguage
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : null,
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: ClipOval(
                              child: Image.asset(
                                currentLanguage.imagePath,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(currentLanguage.name),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: Constants.countriesFlag.length,
          );
        },
      ),
    );
  }
}
