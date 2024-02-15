part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class ChangeThemeEvent extends SettingEvent {
  final bool isDarkTheme;

  const ChangeThemeEvent(this.isDarkTheme);
}

class LoadSettingEvent extends SettingEvent {}

class ChangeLanguageEvent extends SettingEvent {
  final Language newLanguage;

  const ChangeLanguageEvent(this.newLanguage);
}
