import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/screens/create_delivery_post_screen.dart';
import 'package:carshop_mobile/screens/create_post_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/screens/map_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late AuthenticationBloc authenticationBloc;
  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    BlocProvider(
      create: (context) => MapBloc()..add(GetCurrentLocationEvent()),
      child: MapScreen(),
    ),
    const CreateDeliveryPostScreen(),
    const CreatePostScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carshop posts'),
        actions: [
          ///TODO Temporary add logout button
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: GestureDetector(
                onTap: () {
                  authenticationBloc =
                      BlocProvider.of<AuthenticationBloc>(context);
                  authenticationBloc.add(SignOutEvent());
                },
                child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is SignedOutState) {
                      UiUtilities.pushReplacement(context, LoginScreen());
                    }
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ),
        ],
        // backgroundColor: Colors.green
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              //backgroundColor: Colors.green,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
