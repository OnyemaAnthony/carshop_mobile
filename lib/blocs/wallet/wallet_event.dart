part of 'wallet_bloc.dart';

class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetWalletEvent extends WalletEvent {
  const GetWalletEvent();
}

class GetWalletBalanceEvent extends WalletEvent {}

class GetTransactionHistoryEvent extends WalletEvent {}

class InitializeFundingEvent extends WalletEvent {}

class InitializeWithdrawalEvent extends WalletEvent {}
