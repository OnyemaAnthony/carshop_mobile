import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/wallet/wallet_bloc.dart';
import 'package:carshop_mobile/screens/comment_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/screens/my_normal_post_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carshop_mobile/blocs/wallet/wallet_extension.dart';
import 'my_delivery_post_screen.dart';

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
        body: BlocProvider(
          create: (context) => WalletBloc()..add(const GetWalletEvent()),
          child: BlocConsumer<WalletBloc, WalletState>(
            listener: (context, state) {
              if (state is WalletErrorState) {
                UiUtilities.showToast(
                    message: "You don't have a wallet",
                    toast: Toast.LENGTH_SHORT);
              }
            },
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                                color: Theme.of(context).primaryColor,
                                child: Column(
                                  children: [
                                    const Text("Wallet Balance"),
                                    Text(
                                      state.wallet?.getBalance ?? "0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SubmitButton(
                            text: "MyActivites",
                            onPress: () {
                              UiUtilities.navBarReplacement(
                                  context, CommentScreen(), false);
                            },
                          ),
                          SubmitButton(
                            text: "Get my Delivery post",
                            onPress: () {
                              UiUtilities.push(context, MyDeliveryPostScreen());
                            },
                          ),
                          SubmitButton(
                            text: "Get my normal post",
                            onPress: () {
                              UiUtilities.push(context, MyNormalPostScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
