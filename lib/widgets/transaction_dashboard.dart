import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:flutter/material.dart';

import '../blocs/wallet/wallet_bloc.dart';
import '../screens/transaction_history_screen.dart';
import '../utilities/constants.dart';
import '../utilities/ui_utilities.dart';
import 'image_to_icon.dart';

class TransactionDashboard extends StatelessWidget {
  final BuildContext? context;
  final WalletState? state;

  const TransactionDashboard({super.key, this.state, this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Row(
              children: [
                Text('total_balance'.trans(context),
                    style: Theme.of(context).textTheme.bodySmall),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    UiUtilities.pushNavBar(
                        context, const TransactionHistoryScreen(), false);
                  },
                  child: Text("${'transaction_history'.trans(context)} >",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text("\$ ${state?.wallet?.balance.value}",
              style: Theme.of(context).textTheme.bodyLarge),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 82),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // walletBloc.add(InitializeFundingEvent());
                  },
                  child: Column(
                    children: [
                      const ImageToIcon(
                        color: Colors.white,
                        width: 40,
                        height: 40,
                        imagePath: Constants.addIconPath,
                      ),
                      Text('add_money'.trans(context),
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const Spacer(flex: 50),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const ImageToIcon(
                        color: Colors.white,
                        width: 40,
                        height: 40,
                        imagePath: Constants.transferIconPath,
                      ),
                      Text(
                        'transfer'.trans(context),
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 50),
                Column(
                  children: [
                    const ImageToIcon(
                      width: 40,
                      height: 40,
                      imagePath: Constants.downArrowIconPath,
                    ),
                    Text('withdraw'.trans(context),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
