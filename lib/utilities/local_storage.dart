import 'dart:convert';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveString({
    required String key,
    String? value,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value!);
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

  static Future<AuthenticatedUserDescriptor?> fetchCachedUser() async {
    String? cacheUser = await getString('cached_user');
    if (cacheUser.isNotEmpty) {
      dynamic newCachedUser = cacheUser.substring(1, cacheUser.length - 1);
      newCachedUser = jsonDecode(newCachedUser.replaceAllMapped(
          RegExp(r'(\w+):\s*([^,}\s]+)'),
          (match) => '"${match.group(1)}": "${match.group(2)}"'));

      AuthenticatedUserDescriptor? user =
          AuthenticatedUserDescriptor?.fromJson(newCachedUser);
      return user;
    }
    return null;
  }

  static Future<void> saveUser({
    required AuthenticatedUserDescriptor user,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cached_user', jsonEncode(user.toJson().toString()));
  }
}
