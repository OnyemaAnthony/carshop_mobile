import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:carshop_mobile/models/address/address.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository? repository;
  AddressBloc({this.repository}) : super(AddressInitial()) {
    on<GetAllAddressEvent>(_mapGetAllAddressEventToState);
    on<DeleteAddressEvent>(_mapDeleteAddressEventEventToState);
    on<UpdateAddressEvent>(_mapUpdateAddressEventEventToState);
    on<GetSingleAddressEvent>(_mapGetSingleAddressEventEventToState);
    on<SaveAddressEvent>(_mapSaveAddressEventEventToState);
  }

  FutureOr<void> _mapGetAllAddressEventToState(GetAllAddressEvent event, Emitter<AddressState> emit)async {
    emit(AddressLoadingState());
    final response =await repository!.getAllAddress();
    response.fold((l) {
      emit(AddressErrorState(l.message));
    }, (addresses) {
      emit(AddressLoadedState(addresses));
    });
  }

  FutureOr<void> _mapDeleteAddressEventEventToState(DeleteAddressEvent event, Emitter<AddressState> emit)async {
    emit(AddressLoadingState());
    final response =await repository!.deleteAddress(event.addressId);
    response.fold((l) {
      emit(AddressErrorState(l.message));
    }, (r) {
      emit(AddressDeletedState());
    });
  }

  FutureOr<void> _mapUpdateAddressEventEventToState(UpdateAddressEvent event, Emitter<AddressState> emit) async{
    emit(AddressLoadingState());
    final response =await repository!.updateAddress(event.address);
    response.fold((l) {
      emit(AddressErrorState(l.message));
    }, (address) {
      emit(AddressLoadState(address));
      });
  }

  FutureOr<void> _mapGetSingleAddressEventEventToState(GetSingleAddressEvent event, Emitter<AddressState> emit) async{
    emit(AddressLoadingState());
    final response =await repository!.getSingleAddress(event.addressId);
    response.fold((l) {
      emit(AddressErrorState(l.message));
    }, (address) {
      emit(AddressLoadState(address));
    });
  }

  FutureOr<void> _mapSaveAddressEventEventToState(SaveAddressEvent event, Emitter<AddressState> emit) async{
    emit(AddressLoadingState());
    final response =await repository!.saveAddress(event.address);
    response.fold((l) {
      emit(AddressErrorState(l.message));
    }, (address) {
      emit(AddressLoadState(address));
    });
  }
}
