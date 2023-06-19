import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/repositories/user_repository.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  late AuthenticationBloc authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationBloc(repository: UserRepository(ApiRequest())),
      child: Scaffold(
        backgroundColor: const Color(0xFF2C384A),
        body: Builder(builder: (BuildContext context) {
          authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
          return BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Authenticated) {
                UiUtilities.pushReplacement(context, const BottomNavigationBarScreen());
              }
            },
            builder: (context, state) {
              return Column(mainAxisSize: MainAxisSize.max, children: [
                const Row(),
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Carshop',
                        style: TextStyle(
                          color: Color(0xFFFFCA28),
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'Authentication',
                        style: TextStyle(
                          color: Color(0xFFF57C00),
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () {
                      authenticationBloc.add(SignInWithGoogleEvent());

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Image(
                            image: AssetImage('assets/images/google_logo.png'),
                            height: 35.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: state is AuthenticationLoadingState ?const CircularProgressIndicator():const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            },
          );
        }),
      ),
    );
  }
}
