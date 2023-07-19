part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const AddressEvent();
}

class SaveAddressEvent extends AddressEvent {
  final CreateAddressDto createAddressDto;

  const SaveAddressEvent(this.createAddressDto);
}

class GetAllAddressEvent extends AddressEvent {}

class GetSingleAddressEvent extends AddressEvent {
  final String id;

  const GetSingleAddressEvent(this.id);
}

class UpdateAddressEvent extends AddressEvent {
  final UpdateAddressDto updateAddressDto;
  final String id;

  const UpdateAddressEvent(this.id, this.updateAddressDto);
}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  const DeleteAddressEvent(this.addressId);
}
