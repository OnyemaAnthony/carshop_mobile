part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  const WalletState(
      {this.errorMessage,
      this.wallet,
      this.transactions,
      this.page = 0,
      this.size = 10});

  final WalletDescriptor? wallet;
  final TransactionsInDescendingOrderDescriptor? transactions;
  final int page;
  final int size;
  final String? errorMessage;

  WalletState copyWith(
      {WalletDescriptor? wallet,
      TransactionsInDescendingOrderDescriptor? transactions,
      int? page,
      int? size}) {
    return WalletState(
        wallet: wallet ?? this.wallet,
        transactions: transactions ?? this.transactions,
        page: page ?? this.page,
        size: size ?? this.size);
  }

  @override
  List<Object> get props => [page, size, wallet ?? [], transactions ?? []];
}

class WalletInitial extends WalletState {
  const WalletInitial(
      {super.wallet, super.transactions, super.page, super.size});
}

class WalletErrorState extends WalletState {
  final String errorMessage;

  const WalletErrorState(this.errorMessage,
      {super.wallet, super.transactions, super.page, super.size});
}
