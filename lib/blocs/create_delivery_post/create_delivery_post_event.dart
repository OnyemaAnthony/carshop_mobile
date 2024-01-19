part of 'create_delivery_post_bloc.dart';

@immutable
abstract class CreateDeliveryPostEvent extends Equatable {

  const CreateDeliveryPostEvent();

  @override

  List<Object?> get props => [];
}

class PushDeliveryEvent extends CreateDeliveryPostEvent{
  final String taskTitle   ;
  final String taskDesc ;
  final BuildContext context;

   const PushDeliveryEvent(this.context,this.taskTitle,this.taskDesc);
}

class PushTimeEvent extends CreateDeliveryPostEvent{

  final BuildContext context;

  const PushTimeEvent({required this.context});
}
class PushBudgetEvent extends CreateDeliveryPostEvent{
  final String date;
  final String time;
  final BuildContext context;
  const PushBudgetEvent(this.context,this.date,this.time);
}
class SwitchUseMyPickupEvent extends CreateDeliveryPostEvent {
  final bool newValue ;
   SwitchUseMyPickupEvent({required this.newValue});
}

class SwitchUseMyDropOffEvent extends CreateDeliveryPostEvent{
  final bool newValue ;
  SwitchUseMyDropOffEvent({required this.newValue});
}

class SwitchOpenToOffersEvent extends CreateDeliveryPostEvent{
  final bool newValue ;
  SwitchOpenToOffersEvent({required this.newValue});
}
class SaveDeliveryPostEvent extends CreateDeliveryPostEvent {
  final CreateDeliveryPost createDPDto;

  const SaveDeliveryPostEvent(this.createDPDto);
}

/*
class SharePostEvent extends CreateDeliveryPostEvent{
  final String budget ;
  const SharePostEvent(this.budget);

}*/
