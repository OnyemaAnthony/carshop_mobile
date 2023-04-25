part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {

}
class Authenticated extends AuthenticationState{
  final UserModel? userModel;

  const Authenticated(this.userModel);

}

class AuthenticationLoadingState extends AuthenticationState{

}

class AuthenticationErrorState extends AuthenticationState{
  final String errorMessage;

  const AuthenticationErrorState(this.errorMessage);

}

class UnAuthenticated extends AuthenticationState{

}
