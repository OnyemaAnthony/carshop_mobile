import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utilities/navigator_keys.dart';

class FirebaseService {
  Future<bool?> isSignedIn() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var currentUser = firebaseAuth.currentUser;

    //TODO: maybe our backend deactivated this user, maybe he logged out
    // we should keep firebase and our backend in sync

    String token = await LocalStorage.getString('access_token');
    if (currentUser != null && token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        return await userCredential.user!.getIdToken();
      }
    } catch (e) {
      print("google auth error: $e");
    }
    return null;
  }

  Future<String?> signInWithFacebook() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
        final AuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
          loginResult.accessToken!.token,
        );
        final UserCredential userCredential =
            await auth.signInWithCredential(facebookAuthCredential);
        return userCredential.user?.getIdToken();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String?> signInWithMicrosoft() async {
    try {
      final Config config = Config(
          tenant: 'common',
          clientId: '2e8c51f3-96d1-485b-aefe-29140a70af45',
          scope: 'User.Read',
          redirectUri:
              'https://carshop-app.azurewebsites.net/auth/microsoft/callback/sign_in',
          navigatorKey: NavigatorKeys.loginNavigatorKey);
      final AadOAuth auth = AadOAuth(config);
      await auth.login();
      return await auth.getAccessToken();
    } catch (e) {
      return null;
    }
  }
}
