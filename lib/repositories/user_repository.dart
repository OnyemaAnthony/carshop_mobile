import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/utilities/request_error.dart';
import 'package:dartz/dartz.dart';
import 'package:carshop_mobile/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final ApiRequest request;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  UserRepository(this.request);

  Future<Either<RequestError, UserModel>> signUp(UserModel user) async {
    try {
      final response = await request.post('url',body: user.toJson());

      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  bool? isSignedIn() {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void>signOut()async{
    firebaseAuth.signOut();

  }

  Future<Either<RequestError, UserModel>>signInWithGoogle()async{

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();



      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;


        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        UserModel userModel = UserModel(code: await userCredential.user!.getIdToken() );
        print(userModel.toGoogleJson());
       //final response =  await request.post('${ApiKeys.baseUrl}/auth/oauth/google',body:userModel.toGoogleJson() );
        return Right(UserModel(id: user!.uid));
      }

      return Right(UserModel());
    }catch(e){
      print('the errror is ${e.toString()}');
      return Left(RequestError(e));
    }
   }

  }
