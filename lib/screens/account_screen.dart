import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/wallet/wallet_bloc.dart';
import 'package:carshop_mobile/screens/comment_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/screens/my_normal_post_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_delivery_post_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        return BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(),
          child: BlocConsumer<WalletBloc, WalletState>(
            listener: (_, __) {},
            builder: (_, walletState) {
              return _ScreenBuilder(context, authenticationState, walletState)
                  .build();
            },
          ),
        );
      },
    );
  }
}

class _ScreenBuilder {
  final BuildContext context;
  final AuthenticationState authenticationState;
  final WalletState walletState;
  final Widget nullWidget = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  const _ScreenBuilder(
      this.context, this.authenticationState, this.walletState);

  void _handleLogoutIconPressed() {
    context.read<AuthenticationBloc>().add(SignOutEventTest());
  }

  Widget build() {
    if (authenticationState is SignedOutState) {
      return _navigateToLogin();
    } else {
      return _buildScreen();
    }
  }

  Widget _navigateToLogin() {
    UiUtilities.navBarReplacement(context, const LoginScreen(), false);
    return nullWidget;
  }

  Widget _buildScreen() {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    var logoutAction = IconButton(
        onPressed: _handleLogoutIconPressed, icon: const Icon(Icons.logout));

    return AppBar(
      title: const Text("Account"),
      centerTitle: true,
      actions: [logoutAction],
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SizedBox.expand(
        child: Column(
          children: [_buildWallet(flex: 3), _buildNavigationButtons(flex: 7)],
        ),
      ),
    );
  }

  Widget _buildWallet({required int flex}) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      gradient: const LinearGradient(
        colors: [Colors.blueAccent, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );

    const textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    handlePress() => null;

    var top = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total Balance", style: textStyle),
        GestureDetector(
            onTap: handlePress,
            child: const Text("Transaction History >", style: textStyle)),
      ],
    );

    const money = Text(
      '\$5000', // Replace with actual balance or dynamic data
      style: TextStyle(
        fontSize: 36,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    const fund = Text("Fund", style: textStyle);
    const withdraw = Text("Withdraw", style: textStyle);
    const icons = Row(
        mainAxisAlignment: MainAxisAlignment.start, children: [fund, withdraw]);

    return Expanded(
      flex: flex,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [top, money, icons],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons({required int flex}) {
    var divider = const Divider(
      color: Colors.grey,
      thickness: 1,
    );

    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavigationButton(
              text: 'MyActivites',
              routeScreen: CommentScreen(),
              divider: divider),
          _buildNavigationButton(
              text: "Get my Delivery post",
              routeScreen: const MyDeliveryPostScreen(),
              divider: divider),
          _buildNavigationButton(
              text: "Get my normal post",
              routeScreen: const MyNormalPostScreen(),
              divider: nullWidget)
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
      {required String text,
      required Widget routeScreen,
      required Widget divider}) {
    handlePress() => UiUtilities.push(context, routeScreen);

    Widget textContainer = Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );

    return GestureDetector(
      onTap: handlePress,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Column(
            children: [textContainer, divider],
          )),
    );
  }
}
