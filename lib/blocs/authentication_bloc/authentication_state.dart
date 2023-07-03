part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {

}
class Authenticated extends AuthenticationState{
  final UserResponse? userModel;

  const Authenticated(this.userModel);

}
class UserLoadedState extends AuthenticationState{
  final UserResponse? userModel;

  const UserLoadedState(this.userModel);

}

class AuthenticationLoadingState extends AuthenticationState{

}

class AuthenticationErrorState extends AuthenticationState{
  final String errorMessage;

  const AuthenticationErrorState(this.errorMessage);

}

class UnAuthenticated extends AuthenticationState{

}
class SignedOutState extends AuthenticationState{

}