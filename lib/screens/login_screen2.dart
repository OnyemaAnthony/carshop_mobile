import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/submit_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Image.asset(
            //     'assets/image.png',
            //     width: 150,
            //     height: 150,
            //   ),
            // ),
            const Text(
              'Welcome to MyApp',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubmitButton(
                    text: 'Google',
                    logo: Image.asset(
                      'assets/images/google_logo.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  SubmitButton(
                    text: 'Apple',
                    logo: Image.asset(
                      'assets/images/apple.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  SubmitButton(
                    text: 'Microsoft',
                    logo: Image.asset(
                      'assets/images/microsoft.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  SubmitButton(
                    text: 'Facebook',
                    logo: Image.asset(
                      'assets/images/facebook.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
