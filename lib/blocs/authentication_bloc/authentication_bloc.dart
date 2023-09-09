import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/repositories/firebase_services.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:logger/logger.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignUpEvent>(_mapSignUpEventToState);
    on<SignInWithGoogleEvent>(_mapSignInWithGoogleEventToState);
    on<SignInWithFacebookEvent>(_mapSignInWithFacebookEventToState);
    on<SignInWithAppleEvent>(_mapSignInWithAppleEventToState);
    on<SignInWithMicrosoftEvent>(_mapSignInWithMicrosoftEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<UpdateUserEvent>(_mapUpdateUserEventToState);
    on<DeactivateEvent>(_mapDeactivateEventToState);
    on<AppStartedEvent>(_mapAppStartedEventToState);
    on<SignOutEvent>(_mapSignOutEventToState);
    on<SignOutEventTest>(_mapSignOutEventTest);
  }

  FutureOr<void> _mapSignUpEventToState(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    var client = CarshopSDK().client;
    final response = await client.authOauthGooglePost(body: event.authDto);

    if (response.statusCode == 200) {
      emit(Authenticated(response.body));
    } else {
      emit(AuthenticationErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapSignInWithGoogleEventToState(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    final logger = Logger();
    emit(AuthenticationLoadingState());
    String? code = await FirebaseService().signInWithGoogle();
    if (code != null) {
      AuthenticateBodyDto auth = AuthenticateBodyDto(
        code: code,
      );
      var client = CarshopSDK().client;
      final response = await client.authOauthGooglePost(body: auth);
      if (response.statusCode == 200) {
        LocalStorage.saveString(
            key: 'cached_user',
            googleAuthResponse: response.body,
            isCached: true);
        LocalStorage.saveString(
            key: "access_token", value: response.body!.data.auth!.accessToken!);
        emit(Authenticated(response.body));
      } else {
        emit(AuthenticationErrorState(response.error.toString()));
      }
    }
  }

  FutureOr<void> _mapSignInWithFacebookEventToState(
      SignInWithFacebookEvent event, Emitter<AuthenticationState> emit) async {
    String? code = await FirebaseService().signInWithFacebook();
    emit(AuthenticationLoadingState());
    if (code != null) {
      AuthenticateBodyDto auth = AuthenticateBodyDto(
        code: code,
      );
      var client = CarshopSDK().client;
      /// here we need edit to facebook end point
      final response = await client.authOauthGoogleDevPost(body: auth);
      if (response.statusCode == 200) {
        LocalStorage.saveString(
            key: 'cached_user',
            googleAuthResponse: response.body,
            isCached: true);
        LocalStorage.saveString(
            key: "access_token", value: response.body!.data.auth!.accessToken!);
        emit(Authenticated(response.body));
      } else {
        emit(AuthenticationErrorState(response.error.toString()));
      }
    }
  }

  FutureOr<void> _mapSignInWithAppleEventToState(
      SignInWithAppleEvent event, Emitter<AuthenticationState> emit) {}

  FutureOr<void> _mapSignInWithMicrosoftEventToState(
      SignInWithMicrosoftEvent event, Emitter<AuthenticationState> emit) async {
    String? token = await FirebaseService().signInWithMicrosoft();
    print('token');
    print(token);
  }

  FutureOr<void> _mapAppStartedEventToState(
      AppStartedEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    Logger logger = Logger();
    FirebaseAuth auth = FirebaseAuth.instance;

    String token = await LocalStorage.getString('access_token');
    bool isLoggedIn =
        token.isNotEmpty && !Jwt.isExpired(token) && auth.currentUser != null;
    if (isLoggedIn) {
      GoogleAuthResponse? user = await LocalStorage.fetchCachedUser();
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _mapSignOutEventToState(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    var client = CarshopSDK().client;
    final response = await client.authLogoutPost();
    if (response.statusCode == 200) {
      emit(SignedOutState());
    } else {
      emit(AuthenticationErrorState(response.error.toString()));
    }
  }

  /// test
  FutureOr<void> _mapSignOutEventTest(
      SignOutEventTest event, Emitter<AuthenticationState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(SignedOutState());
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    var client = CarshopSDK().client;
    final response = await client.usersGet();

    if (response.statusCode == 200) {
      emit(UserLoadedState(response.body));
    } else {
      emit(AuthenticationErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapUpdateUserEventToState(
      UpdateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    var client = CarshopSDK().client;
    final response = await client.usersPatch(body: event.userUpdateDto);

    if (response.statusCode == 200) {
      emit(UserLoadedState(response.body));
    } else {
      emit(AuthenticationErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapDeactivateEventToState(
      DeactivateEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    var client = CarshopSDK().client;
    final response = await client.authDeactivatePost();

    if (response.statusCode == 200) {
      emit(UnAuthenticated());
    } else {
      emit(AuthenticationErrorState(response.error.toString()));
    }
  }
}
