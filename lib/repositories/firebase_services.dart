import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
}
