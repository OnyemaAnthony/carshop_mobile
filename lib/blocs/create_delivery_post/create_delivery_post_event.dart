part of 'create_delivery_post_bloc.dart';

@immutable
abstract class CreateDeliveryPostEvent extends Equatable {

  const CreateDeliveryPostEvent();

  @override

  List<Object?> get props => [];
}
class OpenNextPageEvent extends CreateDeliveryPostEvent{
final double pageNum ;
const OpenNextPageEvent({this.pageNum=1/4});
}

class PushDeliveryEvent extends CreateDeliveryPostEvent{
  final BuildContext context;

   PushDeliveryEvent(this.context);
}
class PushTimeEvent extends CreateDeliveryPostEvent{
  final BuildContext context;
  PushTimeEvent(this.context);
}
