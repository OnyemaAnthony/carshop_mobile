import 'dart:async';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/utilities/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<GetWalletBalanceEvent>(_mapGetWalletBalanceEventToState);
    on<GetTransactionHistoryEvent>(_mapGetTransactionHistoryEventEventToState);
    on<InitializeFundingEvent>(_mapInitializeFundingEventEventEventToState);
    on<InitializeWithdrawalEvent>(
        _mapInitializeWithdrawalEventEventEventToState);
  }

  FutureOr<void> _mapGetWalletBalanceEventToState(
      GetWalletBalanceEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoadingState());
    var client = CarshopSDK().client;
    var response = await client.walletsMeGet();

    if (response.body != null) {
      emit(WalletLoadedState(wallet: response.body));
    } else {
      emit(WalletErrorState(response.error!.toString(),
          wallet: state.wallet,
          transactions: state.transactions,
          page: state.page,
          size: state.size));
    }
  }

  FutureOr<void> _mapGetTransactionHistoryEventEventToState(
      GetTransactionHistoryEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoadingState());
    var client = CarshopSDK().client;
    var response = await client.walletsTransactionsMeInDescendingOrderGet(
        pageNumber: 1, pageSize: 20);
    Log.d(response.body);
    if (response.body != null) {
      emit(WalletTransactionLoadedState(response.body));
    } else {
      emit(WalletErrorState(response.error!.toString(),
          wallet: state.wallet,
          transactions: state.transactions,
          page: state.page,
          size: state.size));
    }
  }

  FutureOr<void> _mapInitializeFundingEventEventEventToState(
      InitializeFundingEvent event, Emitter<WalletState> emit) async {
    //emit(WalletLoadingState());
    var client = CarshopSDK().client;
    const transaction = StripeInitiateTransaction(amountInCents: 100);
    var response =
        await client.walletStripeInitiateFundingPost(body: transaction);

    if (response.body != null) {
      makePayment(response.body!.stripeCreatedPayment.paymentIntentId,
          response.body!.stripeCreatedPayment.clientSecret);
    } else {
      emit(WalletErrorState(response.error!.toString(),
          wallet: state.wallet,
          transactions: state.transactions,
          page: state.page,
          size: state.size));
    }
  }

  FutureOr<void> _mapInitializeWithdrawalEventEventEventToState(
      InitializeWithdrawalEvent event, Emitter<WalletState> emit) {}
}

Future<void> makePayment(
    String paymentIntentClientSecret, String clientSecrete) async {
  try {
    // var gpay = const PaymentSheetGooglePay(
    //     merchantCountryCode: "USA",
    //     currencyCode: "USD",
    //     testEnv: true,
    //     amount: '1000');
    //
    // final response = await Stripe.instance.initPaymentSheet(
    //   paymentSheetParameters: SetupPaymentSheetParameters(
    //     paymentIntentClientSecret: paymentIntentClientSecret,
    //     customFlow: true,
    //     style: ThemeMode.light,
    //     merchantDisplayName: 'Anthony',
    //     googlePay: gpay,
    //   ),
    // );
  } catch (err) {}
}

displayPaymentSheet() async {
  try {
    // await Stripe.instance.presentPaymentSheet().then((value) {});
  } catch (e) {
    throw Exception(e);
  }
}
