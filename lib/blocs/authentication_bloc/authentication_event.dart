part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const AuthenticationEvent();
}

class SignUpEvent extends AuthenticationEvent {
  final AuthenticateBodyDto authDto;

  const SignUpEvent(this.authDto);
}

class SignInWithGoogleEvent extends AuthenticationEvent {
  final AuthenticateBodyDto authDto;

  const SignInWithGoogleEvent(this.authDto);
}

class AppStartedEvent extends AuthenticationEvent {}

class SignOutEvent extends AuthenticationEvent {}

class DeactivateEvent extends AuthenticationEvent {}

class UpdateUserEvent extends AuthenticationEvent {
  final UserUpdateBodyDto userUpdateDto;

  const UpdateUserEvent(this.userUpdateDto);
}

class GetUserEvent extends AuthenticationEvent {}
