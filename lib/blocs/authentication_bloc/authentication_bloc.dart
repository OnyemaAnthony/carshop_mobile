import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignUpEvent>(_mapSignUpEventToState);
    on<SignInWithGoogleEvent>(_mapSignInWithGoogleEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<UpdateUserEvent>(_mapUpdateUserEventToState);
    on<DeactivateEvent>(_mapDeactivateEventToState);
    on<AppStartedEvent>(_mapAppStartedEventToState);
    on<SignOutEvent>(_mapSignOutEventToState);
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
    var client = CarshopSDK().client;
    final response = await client.authOauthGooglePost(body: event.authDto);

    if (response.statusCode == 200) {
      logger.d(response.body);

      emit(Authenticated(response.body));
    } else {
      emit(AuthenticationErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapAppStartedEventToState(
      AppStartedEvent event, Emitter<AuthenticationState> emit) async {
    //TODO: check token expiration date. it doesn't need a call to the server
    var client = CarshopSDK().client;
    final response = await client.authDetailsGet();
    if (response.statusCode == 200) {}

    emit(UnAuthenticated());
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
