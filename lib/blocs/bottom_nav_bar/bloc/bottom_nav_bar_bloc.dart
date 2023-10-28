import 'package:carshop_mobile/screens/account_screen.dart';
import 'package:carshop_mobile/screens/map_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc()
      : super(BottomNavBarInitial(
            screens: const [],
            controller: PersistentTabController(initialIndex: 0))) {
    var mapScreen = MapScreen();
    var screens = <Widget>[
      mapScreen,
      mapScreen,
      const AccountScreen(),
    ];

    emit(BottomNavBarState(controller: state.controller, screens: screens));

    on<BottomNavBarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
