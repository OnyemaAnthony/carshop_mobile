import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/login_screen/top_curves_custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/login_screen/bottom_curve_custom_paint.dart';
import '../widgets/login_screen/login_ways_column.dart';

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
          const Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopCurveCustomPaint(),
                LoginWaysColumn(),
                BottomCurveCustomPaint()
              ],
            ),
          ),
          if (state is AuthenticationLoadingState) UiUtilities.showLoader()
        ],
      ),
    );
  }
}
