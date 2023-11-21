part of 'nav_bar_bloc.dart';

@immutable
abstract class NavBarEvent {}

class UpdateNavBarIndexEvent extends NavBarEvent{
  final int index;

  UpdateNavBarIndexEvent(this.index);
}
