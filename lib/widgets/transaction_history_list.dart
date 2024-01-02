import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/image_to_icon.dart';
import 'package:flutter/material.dart';

class TransactionHistoryList extends StatelessWidget {
  TransactionsInDescendingOrderDescriptor? transactions;

  TransactionHistoryList({super.key, this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions!.transactions.length,
      itemBuilder: (context, index) {
        TransactionDescriptor transaction = transactions!.transactions[index];

        return ListTile(
          title: Text(
            transaction.purposeType.value!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontSize: 14),
          ),
          subtitle: Text(
            UiUtilities.formatDate(transaction.createdAt),
            style: const TextStyle(color: Colors.black),
          ),
          leading: const ImageToIcon(
            imagePath: Constants.history1IconPath,
          ),
          trailing: Column(
            children: [
              Text(
                '+ \$ ${transaction.grossAmount.value.toString()}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Successful',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
