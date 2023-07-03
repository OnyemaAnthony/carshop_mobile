import 'package:shared_preferences/shared_preferences.dart';
class LocalStorage{

 static Future<void>saveString({required String key,required String value})async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String>getString(String key)async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   return preferences.getString(key)??'';
  }

 static Future<void>clear()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.clear();

 }
}