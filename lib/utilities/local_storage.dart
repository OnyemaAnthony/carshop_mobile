import 'dart:convert';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveString({required String key, String? value, bool isCached = false,GoogleAuthResponse? googleAuthResponse}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isCached) {
      String cacheUser = jsonEncode(googleAuthResponse);
      preferences.setString(key, cacheUser);
    } else {
      preferences.setString(key, value!);
    }
  }

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? '';
  }

  static Future<void> removeString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static Future<GoogleAuthResponse?> fetchCachedUser() async {
    String? cacheUser = await getString('cached_user');
    if (cacheUser.isNotEmpty) {
      GoogleAuthResponse user = GoogleAuthResponse.fromJson(jsonDecode(cacheUser));
      return user;
    }
    return null;
  }
}
