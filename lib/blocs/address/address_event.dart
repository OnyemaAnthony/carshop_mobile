part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const AddressEvent();
}
class SaveAddressEvent extends AddressEvent{
  final Address address;

  const SaveAddressEvent(this.address);
}

class GetAllAddressEvent extends AddressEvent{

}

class GetSingleAddressEvent extends AddressEvent{
  final String addressId;

  const GetSingleAddressEvent(this.addressId);
}

class UpdateAddressEvent extends AddressEvent{
  final Address address;

  const UpdateAddressEvent(this.address);
}

class DeleteAddressEvent extends AddressEvent{
  final String addressId;

  const DeleteAddressEvent(this.addressId);
}