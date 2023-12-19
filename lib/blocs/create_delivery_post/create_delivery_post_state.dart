part of 'create_delivery_post_bloc.dart';
@immutable

abstract class CreateDeliveryPostState extends Equatable {

  double pageNum = 1/4 ;
  @override
  List<Object> get props => [pageNum];
}

class InitialState extends CreateDeliveryPostState {
  double pageNum  ;
  InitialState({required this.pageNum,});
}

class loadinState extends CreateDeliveryPostState{}

class taskDescriptionState extends CreateDeliveryPostState{

}
class deliveryLocationState extends CreateDeliveryPostState{}

class timeState extends CreateDeliveryPostState{}


