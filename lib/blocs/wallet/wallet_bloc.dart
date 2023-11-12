import 'dart:async';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const WalletInitial()) {
    on<WalletEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetWalletEvent>(initWallet);
  }

  FutureOr<void> initWallet(
      GetWalletEvent event, Emitter<WalletState> emit) async {
    var client = CarshopSDK().client;

    var response = await client.walletsMeGet();
    if (response.body != null) {
      emit(WalletInitial(wallet: response.body));
    } else {
      emit(WalletErrorState(response.error!.toString(),
          wallet: state.wallet,
          transactions: state.transactions,
          page: state.page,
          size: state.size));
    }
  }
}
