import 'dart:async';
import 'package:logger/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:carshop_mobile/models/user_model.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository? repository;
  AuthenticationBloc({this.repository}) : super(AuthenticationInitial()) {
    on<SignUpEvent>(_mapSignUpEventToState);
    on<SignInWithGoogleEvent>(_mapSignInWithGoogleEventToState);
    on<AppStartedEvent>(_mapAppStartedEventToState);
  }

  FutureOr<void> _mapSignUpEventToState(SignUpEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
      final response = await repository!.signUp(event.userModel);
      response.fold((l) {
        //implement error here
      }, (r) {
        emit(Authenticated(r));
      });

  }

  FutureOr<void> _mapSignInWithGoogleEventToState(SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async{
    final logger = Logger();
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
      bool? isSignedIn = repository!.isSignedIn();
      print('object $isSignedIn');
      if (isSignedIn!) {
        emit(Authenticated(UserModel(id: '1')));
      } else {
        emit((UnAuthenticated()));
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }
}
