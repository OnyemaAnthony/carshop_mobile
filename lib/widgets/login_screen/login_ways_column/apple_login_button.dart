import 'package:carshop_mobile/widgets/login_screen/login_ways_column/social_login_button/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication_bloc/authentication_bloc.dart';

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return SocialLoginButton(
      onPressed: () {
        authenticationBloc.add(SignInWithAppleEvent());
      },
      text: "Sign in with Apple",
      icon: Icons.apple,
      iconColor: Colors.white60,
    );
  }
}
