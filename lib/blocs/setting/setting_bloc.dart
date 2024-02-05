import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/utilities/language.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:carshop_mobile/utilities/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingInitial(CarShopTheme.getLightTheme(), false,
            Constants.getStoredLanguage())) {
    on<ChangeThemeEvent>(_changeTheme);
    on<LoadSettingEvent>(_getSetting);
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  FutureOr<void> _changeTheme(
      ChangeThemeEvent event, Emitter<SettingState> emit) async {
    await LocalStorage.saveTheme(event.isDarkTheme);
    final isDarkTheme = await LocalStorage.getAppTheme(Constants.isDarkTheme);
    ThemeData theme = isDarkTheme
        ? CarShopTheme.getDarkTheme()
        : CarShopTheme.getLightTheme();
    emit(ThemeState(theme, isDarkTheme, state.language));
  }

  FutureOr<void> _getSetting(
      LoadSettingEvent event, Emitter<SettingState> emit) async {
    final isDarkTheme = await LocalStorage.getAppTheme(Constants.isDarkTheme);
    final locale = await LocalStorage.getString(Constants.locale);
    Language language = state.language;
    if (locale.isNotEmpty) {
      language = Constants.countriesFlag
          .where((language) => language.locale.languageCode == locale)
          .first;
    }
    emit(
      ThemeState(
        isDarkTheme
            ? CarShopTheme.getDarkTheme()
            : CarShopTheme.getLightTheme(),
        isDarkTheme,
        language,
      ),
    );
  }

  FutureOr<void> _changeLanguage(
      ChangeLanguageEvent event, Emitter<SettingState> emit) async {
    await LocalStorage.saveLocale(event.newLanguage.locale.languageCode);
    emit(ThemeState(state.theme, state.isDarkTheme, event.newLanguage));
  }
}
