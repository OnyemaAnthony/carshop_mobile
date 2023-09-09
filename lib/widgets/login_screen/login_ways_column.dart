import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/widgets/login_screen/login_ways_column/microsoft_login_button.dart';
import 'package:flutter/material.dart';

import 'login_ways_column/apple_login_button.dart';
import 'login_ways_column/facebook_login_button.dart';
import 'login_ways_column/google_login_button.dart';

class LoginWaysColumn extends StatelessWidget {
  const LoginWaysColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.only(left: 10.screenWidthScale()),
        height: .5.screenHeight(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(
              flex: 1,
            ),
            GoogleLoginButton(),
            FacebookLoginButton(),
            MicrosoftLoginButton(),
            AppleLoginButton(),
            Spacer(
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}
