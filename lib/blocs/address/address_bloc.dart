import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<GetAllAddressEvent>(_mapGetAllAddressEventToState);
    on<DeleteAddressEvent>(_mapDeleteAddressEventEventToState);
    on<UpdateAddressEvent>(_mapUpdateAddressEventEventToState);
    on<GetSingleAddressEvent>(_mapGetSingleAddressEventEventToState);
    on<SaveAddressEvent>(_mapSaveAddressEventEventToState);
  }

  FutureOr<void> _mapGetAllAddressEventToState(
      GetAllAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    var client = CarshopSDK().client;
    final response = await client.addressesGet(offset: 0, limit: 10);

    if (response.statusCode == 200) {
      emit(AddressLoadedState(response.body!));
    } else {
      emit(AddressErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapDeleteAddressEventEventToState(
      DeleteAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());

    var client = CarshopSDK().client;
    final response = await client.addressesIdDelete(id: event.addressId);

    if (response.statusCode == 200) {
      emit(AddressDeletedState());
    } else {
      emit(AddressErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapUpdateAddressEventEventToState(
      UpdateAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());

    var client = CarshopSDK().client;
    final response = await client.addressesIdPatch(
        id: event.id, body: event.updateAddressDto);

    if (response.statusCode == 200) {
      emit(AddressLoadState(response.body!));
    } else {
      emit(AddressErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapGetSingleAddressEventEventToState(
      GetSingleAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());

    var client = CarshopSDK().client;
    final response = await client.addressesIdGet(id: event.id);

    if (response.statusCode == 200) {
      emit(AddressLoadState(response.body!));
    } else {
      emit(AddressErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapSaveAddressEventEventToState(
      SaveAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());

    var client = CarshopSDK().client;
    final response = await client.addressesPost(body: event.createAddressDto);

    if (response.statusCode == 200) {
      emit(AddressLoadState(response.body!));
    } else {
      emit(AddressErrorState(response.error.toString()));
    }
  }
}
