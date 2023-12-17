import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(const NavBarInitial(0)) {
    on<UpdateNavBarIndexEvent>(_updateNavIndex);
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  void _updateNavIndex(
      UpdateNavBarIndexEvent event, Emitter<NavBarState> emit) {
    controller.index = event.index;
    emit(NavBarIndexUpdate(event.index));
  }
}
