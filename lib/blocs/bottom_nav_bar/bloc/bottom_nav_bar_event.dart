part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();

  @override
  List<Object> get props => [];
}

class ChangeScreen extends BottomNavBarEvent {
  final int index;

  const ChangeScreen({required this.index});

  @override
  List<Object> get props => [index];
}
