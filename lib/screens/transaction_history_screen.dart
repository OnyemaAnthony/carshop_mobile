import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/image_to_icon.dart';
import 'package:carshop_mobile/widgets/transaction_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/wallet/wallet_bloc.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          WalletBloc()..add(GetTransactionHistoryEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              UiUtilities.pop(context);
            },
            child: const ImageToIcon(
              imagePath: Constants.lessThanArrowIconPath,
            ),
          ),
          title: Text(
            "Transactions",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletLoadedState) {
              return UiUtilities.showMainLoader();
            } else if (state is WalletErrorState) {
              return UiUtilities.showErrorMessage(
                  state.errorMessage.toString());
            } else if (state is WalletTransactionLoadedState) {
              return state.transaction!.transactions.isEmpty
                  ? Center(
                      child: Text('no_transactions'.trans(context)),
                    )
                  : TransactionHistoryList(
                      transactions: state.transaction,
                    );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
