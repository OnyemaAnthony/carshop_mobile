import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/wallet/wallet_bloc.dart';
import 'package:carshop_mobile/screens/setting_screen.dart';
import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/account_list.dart';
import 'package:carshop_mobile/widgets/image_to_icon.dart';
import 'package:carshop_mobile/widgets/transaction_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const toolBar = SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // );

    // SystemChrome.setSystemUIOverlayStyle(toolBar);
    return BlocProvider(
      create: (BuildContext context) =>
          WalletBloc()..add(GetWalletBalanceEvent()),
      child: SafeArea(
        child: BlocListener<WalletBloc, WalletState>(
          listener: (context, state) {},
          child: Builder(builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('account'.trans(context)),
                centerTitle: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ImageToIcon(
                      onTap: () {
                        UiUtilities.pushNavBar(context, SettingScreen(), false);
                      },
                      color: Colors.black,
                      width: 40,
                      height: 40,
                      imagePath: Constants.settingsIconPath,
                    ),
                  ),
                ],
              ),
              body: BlocConsumer<WalletBloc, WalletState>(
                listener: (context, state) {
                  if (state is WalletErrorState) {
                    UiUtilities.showErrorMessage(state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is WalletLoadingState) {
                    return UiUtilities.accountShimmer();
                  } else {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TransactionDashboard(
                              context: context,
                              state: state,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            AccountList(
                                'personal_information'.trans(context),
                                Constants.personIconPath,
                                Colors.white,
                                context),
                            AccountList(
                                'Activities',
                                Constants.activityIconPath,
                                Colors.white,
                                context),
                            AccountList(
                                'activities'.trans(context),
                                Constants.paymentIconPath,
                                Colors.white,
                                context),
                            AccountList(
                                'address_mgt'.trans(context),
                                Constants.locationIconPath,
                                Colors.white,
                                context),
                            AccountList(
                                'logout'.trans(context),
                                Constants.logoutIconPath,
                                Colors.white,
                                context, onTap: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(SignOutEventTest());
                            }),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
