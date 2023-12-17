import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:jwt_decode/jwt_decode.dart';
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
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? firstName = preferences.getString('user_firstname');
    String? lastName = preferences.getString('user_lastname');
    String? userId = preferences.getString('user_id');
    String? email = preferences.getString('user_email');
    String? accessToken = preferences.getString('access_token');

    if (firstName != null &&
        lastName != null &&
        userId != null &&
        email != null &&
        accessToken != null) {
      DateTime? expireDate = Jwt.getExpiryDate(accessToken);
      if (expireDate != null && !Jwt.isExpired(accessToken)) {
        AuthenticatedUserDescriptor? user = AuthenticatedUserDescriptor(
            firstName: firstName,
            lastName: lastName,
            userId: userId,
            email: email,
            token: Token(
                accessToken: accessToken,
                expiresAt: expireDate,
                userId: UserId(id: userId)));
        return user;
      }
    }
    return null;
  }

  static Future<void> saveUser({
    required AuthenticatedUserDescriptor user,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Future.wait([
      preferences.setString('user_firstname', user.firstName),
      preferences.setString('user_lastname', user.lastName),
      preferences.setString('user_id', user.userId),
      preferences.setString('user_email', user.email),
      preferences.setString('access_token', user.token.accessToken)
    ]);
  }

  static signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('user_firstname');
    preferences.remove('user_lastname');
    preferences.remove('user_id');
    preferences.remove('user_email');
    preferences.remove('access_token');
  }
}
