import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonList extends StatelessWidget {
  const LoginButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInButton(
            text: 'Sign up with Google',
            imagePath: 'assets/images/google_logo.png',
            onPressed: () {
              context.read<AuthenticationBloc>().add(SignInWithGoogleEvent());
            },
          ),
          SignInButton(
            text: 'Sign up with Microsoft',
            imagePath: 'assets/images/microsoft.png',
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(SignInWithMicrosoftEvent());
            },
          ),
          SignInButton(
            text: 'Sign up with Apple',
            imagePath: 'assets/images/apple.png',
            onPressed: () {
              context.read<AuthenticationBloc>().add(SignInWithAppleEvent());
            },
          ),
          SignInButton(
            text: 'Sign up with Facebook',
            imagePath: 'assets/images/facebook.png',
            onPressed: () {
              context.read<AuthenticationBloc>().add(SignInWithFacebookEvent());
            },
          ),
          SignInButton(
            text: 'Sign up as dev',
            imagePath: 'assets/images/dev-icon.png',
            onPressed: () {
              context.read<AuthenticationBloc>().add(SignInForDevEvent());
            },
          ),
        ],
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const SignInButton(
      {super.key,
      required this.text,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Colors.black)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
