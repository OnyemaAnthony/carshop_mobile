part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const AuthenticationEvent();
}
class SignUpEvent extends AuthenticationEvent {
  final UserRequest userModel;

  const SignUpEvent(this.userModel);
}

class SignInWithGoogleEvent extends AuthenticationEvent{

}

class AppStartedEvent extends AuthenticationEvent{

}

class SignOutEvent extends AuthenticationEvent{
}

class DeactivateEvent extends AuthenticationEvent{

}

class UpdateUserEvent extends AuthenticationEvent{
  final UserRequest userRequest;

  const UpdateUserEvent(this.userRequest);
}

class GetUserEvent extends AuthenticationEvent{

}
