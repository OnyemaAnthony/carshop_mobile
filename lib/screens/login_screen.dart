import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/login_screen/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is Authenticated) {
          UiUtilities.pushReplacement(
              context, const BottomNavigationBarScreen());
        } else if (state is AuthenticationErrorState) {
          UiUtilities.showSnackBar(txt: state.errorMessage, context: context);
        }
      },
      builder: (_, state) => Stack(
        children: [
          Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Constants.logoImagePath,
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    '\t\t\t\t Your deliveries.\n Our shared journey.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Log in or Signup',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const LoginButtonList(),
                  const Text(
                    'By signing up you agree to ToC & PP',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          if (state is AuthenticationLoadingState) UiUtilities.showLoader()
        ],
      ),
    );
  }
}
