part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final GoogleAuthResponse$Data$User? userModel;


  @override
  List<Object> get props => [];
  const AuthenticationState({this.userModel});
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {

  const Authenticated(GoogleAuthResponse$Data$User? userModel):super(userModel: userModel);
}

class UserLoadedState extends AuthenticationState {
  // final UpdateUserResponse? userModel;
  //
  // const UserLoadedState(this.userModel);
}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationErrorState(this.errorMessage);
}

class UnAuthenticated extends AuthenticationState {}

class SignedOutState extends AuthenticationState {}
