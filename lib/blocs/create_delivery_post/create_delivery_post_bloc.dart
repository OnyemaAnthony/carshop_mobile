import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/carhsop_sdk.dart';
import '../../screens/delivery_post_screens/budget_screen.dart';
import '../../screens/delivery_post_screens/delivery_location_screen.dart';
import '../../screens/delivery_post_screens/set_time_screen.dart';

part 'create_delivery_post_event.dart';
part 'create_delivery_post_state.dart';

class CreateDeliveryPostBloc extends Bloc<CreateDeliveryPostEvent, CreateDeliveryPostState> {

  CreateDeliveryPostBloc() : super( CreateDeliveryPostState(title: "", description: "",
      pickUpAddress: TextEditingController(),dropOffAddress: TextEditingController(),
      useMyAddressPickUp: false,useMyAddressDropOff: false,openToOffers: false , budget:TextEditingController(),time: "",date: "")){

    on<PushTimeEvent>(_openTimeScreen);
    on<PushDeliveryEvent>(_openDeliveryScreen);
    on<PushBudgetEvent>(_openBudgetScreen);
    on<SwitchUseMyPickupEvent>(_changeUseMyAddressPickup);
    on< SwitchUseMyDropOffEvent>(_changeUseMyAddressDropOff);
    on<SwitchOpenToOffersEvent>(_changeOpenToOffers);
    on<SaveDeliveryPostEvent>(_mapSaveDeliveryPostEventToState);
  }


  void _openDeliveryScreen(
      PushDeliveryEvent event, Emitter<CreateDeliveryPostState>emit){
    emit(state.copyWith(title: event.taskTitle, description: event.taskDesc));
    UiUtilities.push(event.context , BlocProvider.value(
      value: this ,
      child: DeliveryLocation(),
    ));
  }
  void _openTimeScreen(
      PushTimeEvent event , Emitter<CreateDeliveryPostState>emit){
    emit(state.copyWith());

    UiUtilities.push(event.context, BlocProvider.value(
      value : this ,
      child : SetTimeScreen(),
    ));
  }
  void _openBudgetScreen(
      PushBudgetEvent event , Emitter<CreateDeliveryPostState>emit){
    emit(state.copyWith(date: event.date,time: event.time));
    UiUtilities.push(event.context, BlocProvider.value(
      value : this ,
      child : BudgetScreen(),
    ));
  }


  FutureOr<void> _changeUseMyAddressPickup(SwitchUseMyPickupEvent event, Emitter<CreateDeliveryPostState> emit) {
    state.pickUpAddress.text = "" ;
    if (event.newValue){
      state.pickUpAddress.text = "from the data";
    }
    emit(state.copyWith(useMyAddressPickUp : event.newValue,));


  }
  FutureOr<void> _changeUseMyAddressDropOff(SwitchUseMyDropOffEvent event, Emitter<CreateDeliveryPostState> emit) {
    state.dropOffAddress.text = "" ;
    if (event.newValue){
      state.dropOffAddress.text= "from the data";
    }
    emit(state.copyWith(useMyAddressDropOff : event.newValue, ));
  }

  FutureOr<void>_changeOpenToOffers (SwitchOpenToOffersEvent event,Emitter<CreateDeliveryPostState>emit) {
state.budget.text = "";
if (event.newValue){
  state.budget.text="open to offers" ;
}
emit(state.copyWith(openToOffers: event.newValue));
  }

  /* void _sharePost(
      SharePostEvent event, Emitter<CreateDeliveryPostState>emit){
    emit(state.copyWith(budget: event.budget));

  }*/
  FutureOr<void> _mapSaveDeliveryPostEventToState(
      SaveDeliveryPostEvent event, Emitter<CreateDeliveryPostState> emit) async {
    emit(state.copyWith());
    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.deliveryPostsPost(body: event.createDPDto);
    if (response.statusCode == 201) {
      emit(state.copyWith());
    }
  }

}





