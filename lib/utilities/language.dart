import 'dart:ui';

import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String name;
  final String code;
  final String imagePath;
  final String countryCode;

  const Language(
      {required this.name,
      required this.code,
      required this.imagePath,
      required this.countryCode});

  Locale get locale => Locale(code, countryCode.toUpperCase());

  @override
  List<Object?> get props => [code];
}
