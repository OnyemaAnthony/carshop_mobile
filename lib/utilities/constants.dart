import 'package:carshop_mobile/utilities/language.dart';

import 'local_storage.dart';

class Constants {
  ///icons path
  static const String deleteIconPath = 'assets/icons/delete.png';
  static const String addIconPath = 'assets/icons/add.png';
  static const String transferIconPath = 'assets/icons/transfer.png';
  static const String downArrowIconPath = 'assets/icons/down_arrow.png';
  static const String greaterThanArrowIconPath =
      'assets/icons/greater_than_arrow.png';
  static const String personIconPath = 'assets/icons/person.png';
  static const String activityIconPath = 'assets/icons/activity.png';
  static const String paymentIconPath = 'assets/icons/payment.png';
  static const String locationIconPath = 'assets/icons/location.png';
  static const String logoutIconPath = 'assets/icons/logout.png';
  static const String settingsIconPath = 'assets/icons/settings.png';
  static const String deliveryIconPath = 'assets/icons/delivery.png';
  static const String homeIconPath = 'assets/icons/home.png';
  static const String createIconPath = 'assets/icons/create.png';
  static const String profileIconPath = 'assets/icons/profile.png';
  static const String lessThanArrowIconPath =
      'assets/icons/less_than_arrow.png';
  static const String history1IconPath = 'assets/icons/history1.png';
  static const String history2IconPath = 'assets/icons/history2.png';
  static const String history3IconPath = 'assets/icons/history3.png';

  ///images path
  static const String logoImagePath = 'assets/images/logo.png';

  static const String configPath = 'assets/config.yaml';

  ///others
  static List<Language> countriesFlag = [
    const Language(
        name: "English",
        code: "en",
        imagePath: 'assets/flags/gb.png',
        countryCode: 'UK'),
    const Language(
        name: "German",
        code: "de",
        imagePath: 'assets/flags/de.png',
        countryCode: 'DE'),
    const Language(
        name: "Arabic",
        code: "ar",
        imagePath: 'assets/flags/sa.png',
        countryCode: 'SA')
  ];

  static Language getStoredLanguage() {
    String? locale;

    Language language = countriesFlag[0];

    LocalStorage.getString(Constants.locale).then((value) {
      locale = value;
      if (locale!.isNotEmpty) {
        language = Constants.countriesFlag
            .where((lang) => lang.locale.languageCode == locale)
            .first;
        return language;
      }
    });

    return language;
  }

  static const isDarkTheme = 'isDarkTheme';
  static const locale = 'local';
}
