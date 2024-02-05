part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  final ThemeData theme;
  final bool isDarkTheme;
  final Language language;

  const SettingState(this.theme, this.isDarkTheme, this.language);

  @override
  List<Object> get props => [theme, language];
}

class SettingInitial extends SettingState {
  const SettingInitial(super.theme, super.isDarkTheme, super.language);
}

class ThemeState extends SettingState {
  const ThemeState(super.theme, super.isDarkTheme, super.language);
}
