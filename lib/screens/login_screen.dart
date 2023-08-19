import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/repositories/firebase_services.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  late AuthenticationBloc authenticationBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFF2C384A),
        body: Builder(builder: (BuildContext context) {
          authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
          return BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Authenticated) {
                UiUtilities.pushReplacement(
                    context, const BottomNavigationBarScreen());
              }
            },
            builder: (context, state) {
              if (state is AuthenticationLoadingState) {
                return UiUtilities.showLoader();
              }
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
                    onPressed: () async {
                      final logger = Logger();
                      String? code = await FirebaseService().signInWithGoogle();
                      if (code != null) {
                        AuthenticateBodyDto auth = AuthenticateBodyDto(
                          code: code,
                        );
                        authenticationBloc.add(SignInWithGoogleEvent(auth));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/google_logo.png'),
                            height: 35.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
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
