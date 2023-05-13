part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  @override
  List<Object> get props => [];
  const AddressState();
}

class AddressInitial extends AddressState {

}

class AddressLoadedState extends AddressState{
  final List<Address> addresses;

  const AddressLoadedState(this.addresses);
}

class AddressErrorState extends AddressState{
  final String errorMessage;

  const AddressErrorState(this.errorMessage);
}

class AddressLoadingState extends AddressState{

}
class AddressLoadState extends AddressState{
  final Address address;

  const AddressLoadState(this.address);
}
class AddressDeletedState extends AddressState{

}