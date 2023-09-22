import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/screens/my_activities_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SignedOutState) {
          UiUtilities.navBarReplacement(context, const LoginScreen(), false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignOutEventTest());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubmitButton(
                text: "MyActivites",
                onPress: () {
                  UiUtilities.navBarReplacement(
                      context, const MyActivitiesScreen(), false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
