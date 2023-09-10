import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/utilities/images.dart';
import 'package:carshop_mobile/widgets/login_screen/login_ways_column/social_login_button/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      onPressed: () {
        context.read<AuthenticationBloc>().add(SignInWithGoogleEvent());
      },
      text: "Sign in with Google",
      image: AppImages.googleImage,
    );
  }
}
