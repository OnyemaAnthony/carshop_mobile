part of 'create_delivery_post_bloc.dart';
@immutable

class CreateDeliveryPostState extends Equatable {
final String? title ;
final String? description ;

final TextEditingController pickUpAddress ;
final TextEditingController dropOffAddress ;
final TextEditingController budget;
final bool? useMyAddressPickUp;
final bool ? useMyAddressDropOff;

final String? date ;
final String? time;

final bool ? openToOffers ;

 final bool ? isLoading ;

    CreateDeliveryPostState({ required this.title, required this.description,

    required this.pickUpAddress, required this.dropOffAddress,
  required this.useMyAddressPickUp, required this.useMyAddressDropOff,
    required this.date,required this.time, required this.openToOffers,required this.budget,
    this.isLoading
  });

  CreateDeliveryPostState copyWith({
  String? title,
  String? description,
  TextEditingController? budget,
  TextEditingController  ? pickUpAddress ,
  TextEditingController? dropOffAddress,
  bool ? useMyAddressPickUp,
  bool ? useMyAddressDropOff,
  String ? date,
  String ? time,
  bool ? openToOffers ,
  bool ? isLoading,


}) {

  return CreateDeliveryPostState(
      title: title ?? this.title,
      description: description ?? this.description,
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      dropOffAddress : dropOffAddress?? this.dropOffAddress,
      useMyAddressPickUp : useMyAddressPickUp ?? this.useMyAddressPickUp,
      useMyAddressDropOff : useMyAddressDropOff ?? this.useMyAddressDropOff,
      date: date ?? this.date,
      time: time ?? this.time,
      openToOffers : openToOffers ?? this.openToOffers,
      budget: budget?? this.budget,
    isLoading: isLoading ?? this.isLoading,
      );
  }

  @override
  List<Object?> get props => [useMyAddressDropOff , useMyAddressPickUp, pickUpAddress, dropOffAddress,openToOffers,budget];

}





