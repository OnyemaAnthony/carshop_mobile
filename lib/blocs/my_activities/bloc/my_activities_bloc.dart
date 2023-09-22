import 'package:bloc/bloc.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';

part 'my_activities_event.dart';
part 'my_activities_state.dart';

class MyActivitiesBloc extends Bloc<MyActivitiesEvent, MyActivitiesState> {
  MyActivitiesBloc() : super(MyActivitiesInitial()) {
    on<MyActivitiesEvent>((event, emit) {});

    on<GetMyActivitiesEvent>((event, emit) async {
      final client = CarshopSDK().client;
      final activityDTO = await client.userActivitiesGet(limit: 20, offset: 0);
      emit(MyActivitiesState(
          activities: activityDTO.body?.data.activities ?? []));
    });
  }
}
