part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState extends Equatable {
  final PersistentTabController controller;
  final List<Widget> screens;
  const BottomNavBarState({required this.controller, required this.screens});

  @override
  List<Object> get props => [];
}

class BottomNavBarInitial extends BottomNavBarState {
  const BottomNavBarInitial(
      {required super.controller, required super.screens});
}
