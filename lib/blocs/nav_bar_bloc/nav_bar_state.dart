part of 'nav_bar_bloc.dart';

@immutable
abstract class NavBarState {
  final int index;

  const NavBarState(this.index);
}

class NavBarInitial extends NavBarState {
  const NavBarInitial(super.index);
}

class NavBarIndexUpdate extends NavBarState {
  const NavBarIndexUpdate(super.index);
}
