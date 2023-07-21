import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/screens/account_screen.dart';
import 'package:carshop_mobile/screens/create_delivery_post_screen.dart';
import 'package:carshop_mobile/screens/create_post_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/screens/map_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  late AuthenticationBloc authenticationBloc;
  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    MapScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Carshop posts'),
  //       actions: [
  //         ///TODO Temporary add logout button
  //         Padding(
  //           padding: const EdgeInsets.only(top: 20, right: 20),
  //           child: GestureDetector(
  //               onTap: () {
  //                 authenticationBloc =
  //                     BlocProvider.of<AuthenticationBloc>(context);
  //                 authenticationBloc.add(SignOutEvent());
  //               },
  //               child: BlocListener<AuthenticationBloc, AuthenticationState>(
  //                 listener: (context, state) {
  //                   if (state is SignedOutState) {
  //                     UiUtilities.pushReplacement(context, LoginScreen());
  //                   }
  //                 },
  //                 child: const Text(
  //                   'Logout',
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //               )),
  //         ),
  //       ],
  //       // backgroundColor: Colors.green
  //     ),
  //     body: _screens.elementAt(_selectedIndex),
  //     bottomNavigationBar: BottomNavigationBar(
  //         items: const <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.home),
  //               label: 'Home',
  //               backgroundColor: Colors.blue),
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.search),
  //               label: 'Search',
  //               backgroundColor: Colors.blue),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.person),
  //             label: 'Profile',
  //             //backgroundColor: Colors.green,
  //           ),
  //         ],
  //         type: BottomNavigationBarType.shifting,
  //         currentIndex: _selectedIndex,
  //         selectedItemColor: Colors.black,
  //         iconSize: 40,
  //         onTap: _onItemTapped,
  //         elevation: 5),
  //   );
  // }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(CupertinoIcons.search),
      //   title: ("Search"),
      //   activeColorPrimary: CupertinoColors.activeBlue,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),

      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Account"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
