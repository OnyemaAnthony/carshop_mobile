import 'package:carshop_mobile/repositories/user_repository.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (BuildContext context) =>
          AuthenticationBloc(repository: UserRepository(ApiRequest()))
            ..add(AppStartedEvent()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
            builder: (context, state) {
              if(state is Authenticated){
                return const BottomNavigationBarScreen();
              }else if(state is UnAuthenticated){
                return  LoginScreen();
              }else if (state is AuthenticationErrorState){
                return const Center(child: Text('Something went wrong try again later'),);
              }
              return const Center(child: CircularProgressIndicator(),);
              //return LoginScreen();
            }),

      );
  }
}
