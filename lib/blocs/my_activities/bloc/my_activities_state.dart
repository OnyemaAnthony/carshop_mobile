part of 'my_activities_bloc.dart';

class MyActivitiesState extends Equatable {
  const MyActivitiesState({this.activities = const <ActivityResponse>[]});
  final List<ActivityResponse> activities;

  @override
  List<Object> get props => [];
}

class MyActivitiesInitial extends MyActivitiesState {}
