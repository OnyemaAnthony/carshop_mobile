import 'package:carshop_mobile/models/user/user_response.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:carshop_mobile/utilities/request_error.dart';
import 'package:carshop_mobile/widgets/swipe_module/models_extender.dart';
import 'package:dartz/dartz.dart';
import 'package:carshop_mobile/models/user/user_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<Either<RequestError,UserResponse>> updateUser(UserRequest userRequest)async{
    try {
      final response = await request.patch('${ApiKeys.baseUrl}/users',body: userRequest.toJson());
      return Right(UserResponse.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }

  }
  Future<Either<RequestError,UserResponse>> getUser()async{
    try {
      final response = await request.get('${ApiKeys.baseUrl}/users');
      return Right(UserResponse.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }

  }


  Future<bool?> isSignedIn() async{
    var currentUser = firebaseAuth.currentUser;

    String token = await LocalStorage.getString('access_token');
    if(currentUser != null && token.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<Either<RequestError,void>> signOut()async {
    try {
      googleSignIn.signOut();
      firebaseAuth.signOut();
      LocalStorage.clear();
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }
  Future<Either<RequestError,void>> deactivateUser()async {
    try {
      await request.post('${ApiKeys.baseUrl}/auth/deactivate');
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }


  Future<Either<RequestError, UserResponse>>signInWithGoogle()async{
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        UserRequest userModel = UserRequest(code: await userCredential.user!.getIdToken());

        final response =  await request.post('${ApiKeys.baseUrl}/auth/oauth/google',body:userModel.toGoogleJson());

        UserResponse userResponse = UserResponse.fromJson(response);
        LocalStorage.saveString(value: userResponse.data!.auth!.accessToken!, key:'access_token');
        return Right(userResponse);
      }

      return Right(UserResponse());
    }catch(e){
      return Left(RequestError(e));
    }
   }

  }
