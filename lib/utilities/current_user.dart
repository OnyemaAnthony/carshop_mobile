import 'package:firebase_auth/firebase_auth.dart';

abstract class CurrentUser {
  static String? uId;
  static loadCurrentUser() {
    uId = FirebaseAuth.instance.currentUser?.uid;
  }
}
