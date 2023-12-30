import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../screens/deliveryLocation.dart';
import '../../screens/setTimeScreen.dart';

part 'create_delivery_post_event.dart';
part 'create_delivery_post_state.dart';

class CreateDeliveryPostBloc extends Bloc<CreateDeliveryPostEvent, CreateDeliveryPostState> {

  CreateDeliveryPostBloc() : super(CreateDeliveryPostState(title: "", description: "",pageNum: 1/4)){
  on<PushTimeEvent>(_openTimeScreen);
  on<OpenNextPageEvent>(_increasePageNum);
  on<PushDeliveryEvent>(_openDeliveryScreen);

 }
 FutureOr<void>_increasePageNum(
     OpenNextPageEvent event, Emitter<CreateDeliveryPostState>emit)async{
    emit(state.copyWith(pageNum: state.pageNum + 0.25));

 }

  void _openDeliveryScreen(
PushDeliveryEvent event, Emitter<CreateDeliveryPostState>emit){
emit(state.copyWith(pageNum: 2/4));
    UiUtilities.push(event.context , BlocProvider.value(
      value: this ,
      child: DeliveryLocation(),
    ));
}
void _openTimeScreen(
    PushTimeEvent event , Emitter<CreateDeliveryPostState>emit){
      UiUtilities.push(event.context, BlocProvider.value(
      value : this ,
          child : SetTimeScreen(),
      ));
}
Future<void>_MapTaskTitle(
    PushDeliveryEvent event, Emitter<CreateDeliveryPostState>emit)async{
    emit(state.copyWith(title: event.taskTitle,description: event.taskDesc,pageNum:1/4 ));
}



}

