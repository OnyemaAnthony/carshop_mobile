import 'package:carshop_mobile/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:carshop_mobile/screens/account_screen.dart';
import 'package:carshop_mobile/screens/map_screen.dart';
import 'package:carshop_mobile/widgets/bottom_navigation_screen/create_post_widget.dart';
import 'package:carshop_mobile/widgets/bottom_navigation_screen/custom_nav_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc(),
      child: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          NavBarBloc navBarBloc = context.read<NavBarBloc>();
          return PersistentTabView.custom(
            context,
            confineInSafeArea: true,
            handleAndroidBackButtonPress: true,
            controller: navBarBloc.controller,
            screens: const [
              MapScreen(),
              SizedBox.shrink(),
              AccountScreen(),
            ],
            onWillPop: (context) async {
              navBarBloc.add(UpdateNavBarIndexEvent(0));
              return true;
            },
            itemCount: 3,
            customWidget: CustomNavBarWidget(
                selectedIndex: state.index,
                items: [
                  _navBarItem(title: 'Home', icon: CupertinoIcons.home),
                  _navBarItem(title: 'Create', icon: Icons.add_box_outlined),
                  _navBarItem(title: 'Account', icon: CupertinoIcons.person),
                ],
                onItemSelected: (value) {
                  if (value == 1) {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (_) => const CreatePostWidget(),
                    );
                    return;
                  }
                  navBarBloc.add(UpdateNavBarIndexEvent(value));
                }), // Choose the nav bar style with this property.
          );
        },
      ),
    );
  }

  _navBarItem({required String title, required IconData icon}) =>
      PersistentBottomNavBarItem(
        icon: Icon(icon),
        title: title,
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      );
}
