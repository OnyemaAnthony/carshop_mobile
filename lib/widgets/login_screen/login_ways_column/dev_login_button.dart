import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/widgets/login_screen/login_ways_column/social_login_button/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevLoginButton extends StatelessWidget {
  const DevLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      onPressed: () {
        context.read<AuthenticationBloc>().add(SignInForDevEvent());
      },
      text: "Sign in For Dev",
      icon: Icons.developer_mode_outlined,
      iconColor: Colors.white60,
    );
  }
}
