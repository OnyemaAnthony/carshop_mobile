import 'package:carshop_clientsdk/carshop_clientsdk.dart';
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
          title: Text(transaction.grossAmount.value.toString()),
        );
      },
    );
  }
}
