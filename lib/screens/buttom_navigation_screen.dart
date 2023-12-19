import 'package:carshop_mobile/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:carshop_mobile/screens/account_screen.dart';
import 'package:carshop_mobile/screens/delivery_status_screen.dart';
import 'package:carshop_mobile/screens/map_screen.dart';
import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/widgets/bottom_navigation_screen/create_post_widget.dart';
import 'package:carshop_mobile/widgets/bottom_navigation_screen/custom_nav_bar_widget.dart';
import 'package:carshop_mobile/widgets/image_to_icon.dart';
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
              DeliveryStatusScreen(),
              SizedBox.shrink(),
              AccountScreen(),
            ],
            onWillPop: (context) async {
              navBarBloc.add(UpdateNavBarIndexEvent(0));
              return true;
            },
            itemCount: 4,
            customWidget: CustomNavBarWidget(
                selectedIndex: state.index,
                items: [
                  _navBarItem(
                      title: 'Home',
                      icon: ImageToIcon(
                        imagePath: Constants.homeIconPath,
                        color: getColor(state.index, 0, context),
                      ),
                      context: context),
                  _navBarItem(
                      title: 'Delivery',
                      icon: ImageToIcon(
                        imagePath: Constants.deliveryIconPath,
                        color: getColor(state.index, 1, context),
                      ),
                      context: context),
                  _navBarItem(
                      title: 'Create',
                      icon: ImageToIcon(
                        imagePath: Constants.createIconPath,
                        color: getColor(state.index, 2, context),
                      ),
                      context: context),
                  _navBarItem(
                      title: 'Account',
                      icon: ImageToIcon(
                        imagePath: Constants.profileIconPath,
                        color: getColor(state.index, 3, context),
                      ),
                      context: context),
                ],
                onItemSelected: (value) {
                  if (value == 2) {
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

  Color getColor(int currentIndex, int index, BuildContext context) {
    return currentIndex == index
        ? Theme.of(context).primaryColor
        : Colors.black;
  }

  _navBarItem(
          {required String title,
          required Widget icon,
          required BuildContext context}) =>
      PersistentBottomNavBarItem(
        icon: icon,
        title: title,
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      );
}
