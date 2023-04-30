part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const AuthenticationEvent();
}
class SignUpEvent extends AuthenticationEvent {
  final UserModel userModel;

  const SignUpEvent(this.userModel);
}

class SignInWithGoogleEvent extends AuthenticationEvent{

}

class AppStartedEvent extends AuthenticationEvent{

}

class SignOutEvent extends AuthenticationEvent{

}
