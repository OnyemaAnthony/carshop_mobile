import 'package:carshop_mobile/models/user/user_response.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:carshop_mobile/utilities/request_error.dart';
import 'package:dartz/dartz.dart';
import 'package:carshop_mobile/models/user/user_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class UserRepository {
  final ApiRequest request;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();



  UserRepository(this.request);

  Future<Either<RequestError, UserResponse>> signUp(UserRequest user) async {
    try {
      final response = await request.post('url',body: user.toJson());

      return Right(UserResponse.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<bool?> isSignedIn() async{
    var currentUser = firebaseAuth.currentUser;
    String token = await LocalStorage.getString('token');
    if(currentUser != null && token.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<void>signOut()async{
    googleSignIn.signOut();
    firebaseAuth.signOut();

  }

  Future<Either<RequestError, UserResponse>>signInWithGoogle()async{


    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();



      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;


        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        UserRequest userModel = UserRequest(code: await userCredential.user!.getIdToken() );
        final response =  await request.post('${ApiKeys.baseUrl}/auth/oauth/google',body:userModel.toGoogleJson());
        UserResponse userResponse = UserResponse.fromJson(response);
        LocalStorage.saveString(key: 'token', value: userResponse.data!.auth!.accessToken!);
        return Right(userResponse);
      }

      return Right(UserResponse());
    }catch(e){
      return Left(RequestError(e));
    }
   }

  }
