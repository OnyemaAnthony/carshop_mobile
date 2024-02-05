import 'package:carshop_mobile/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class DaynoConfig {
  YamlMap _config = YamlMap();
  static bool _isLoaded = false;
  static final DaynoConfig _instance = DaynoConfig._();

  DaynoConfig._();

  Future<bool> load() async {
    try {
      String yaml = await rootBundle.loadString(Constants.configPath);
      _config = loadYaml(yaml);
      _isLoaded = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  factory DaynoConfig() {
    return _instance;
  }

  static dynamic get(List<String> key) {
    if (!_isLoaded) {
      throw Exception('Config not loaded');
    }
    dynamic result;

    try {
      for (String k in key) {
        if (result == null) {
          result = _instance._config[k];
        } else {
          result = result[k];
        }
      }
    } catch (e) {
      throw Exception('Config key not found');
    }
    return result;
  }
}
