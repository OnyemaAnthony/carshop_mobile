import 'dart:async';
import 'package:carshop_mobile/models/user/user_response.dart';
import 'package:logger/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:carshop_mobile/models/user/user_request.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository? repository;
  AuthenticationBloc({this.repository}) : super(AuthenticationInitial()) {
    on<SignUpEvent>(_mapSignUpEventToState);
    on<SignInWithGoogleEvent>(_mapSignInWithGoogleEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<UpdateUserEvent>(_mapUpdateUserEventToState);
    on<DeactivateEvent>(_mapDeactivateEventToState);
    on<AppStartedEvent>(_mapAppStartedEventToState);
    on<SignOutEvent>(_mapSignOutEventToState);
  }

  FutureOr<void> _mapSignUpEventToState(SignUpEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
      final response = await repository!.signUp(event.userModel);
      response.fold((l) {
      }, (r) {
        emit(Authenticated(r));
      });

  }

  FutureOr<void> _mapSignInWithGoogleEventToState(SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState());
    final response =await repository!.signInWithGoogle();
    response.fold((l) {
      emit(AuthenticationErrorState(l.message));
    }, (user) {
      emit(Authenticated(user));
    });
  }

  FutureOr<void> _mapAppStartedEventToState(AppStartedEvent event, Emitter<AuthenticationState> emit)async {
    try {
      bool? isSignedIn = await repository!.isSignedIn();
      if (isSignedIn!) {
        emit(Authenticated(UserResponse()));
      } else {
        emit((UnAuthenticated()));
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _mapSignOutEventToState(SignOutEvent event, Emitter<AuthenticationState> emit) async{
    try{
      await repository!.signOut();
      emit(UnAuthenticated());

    }catch(e){
      emit(UnAuthenticated());

    }
  }

  FutureOr<void> _mapGetUserEventToState(GetUserEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
    final response =await repository!.getUser();
    response.fold((l) {
      emit(AuthenticationErrorState(l.message));
    }, (user) {
      emit(UserLoadedState(user));
    });

  }

  FutureOr<void> _mapUpdateUserEventToState(UpdateUserEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
    final response =await repository!.updateUser(event.userRequest);
    response.fold((l) {
      emit(AuthenticationErrorState(l.message));
    }, (user) {
      emit(UserLoadedState(user));
    });
  }

  FutureOr<void> _mapDeactivateEventToState(DeactivateEvent event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState());
    final response =await repository!.deactivateUser();
    response.fold((l) {
      emit(AuthenticationErrorState(l.message));
    }, (user) {
      emit(UnAuthenticated());
    });
  }
}
