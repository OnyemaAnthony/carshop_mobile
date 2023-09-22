part of 'my_activities_bloc.dart';

class MyActivitiesEvent extends Equatable {
  const MyActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetMyActivitiesEvent extends MyActivitiesEvent {
  final int offset;
  final int limit;
  const GetMyActivitiesEvent({this.offset = 0, this.limit = 20});
}
