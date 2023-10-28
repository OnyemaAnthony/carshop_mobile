import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/utilities/colors.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:carshop_mobile/utilities/navigator_keys.dart';
import 'package:carshop_mobile/utilities/theme.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
if(kIsWeb){
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCDGETeImjV37jyjyhpHImYg3I53r7GzDg",
      appId: "1:884863427065:web:e08a73b179e7939bbb1d28",
      messagingSenderId: "884863427065",
      projectId: "carshop-eee10",
    ),
  );
}

  await Firebase.initializeApp( );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 756),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MapBloc()..add(GetCurrentLocationEvent()),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                AuthenticationBloc()..add(AppStartedEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme:CarShopTheme.getLightTheme(context) ,
          home:  BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationLoadingState){
            return UiUtilities.showMainLoader();
          }else if(state is Authenticated){
            return const BottomNavigationBarScreen();
          }else if(state is UnAuthenticated){
            return const  LoginScreen();
          }
          ///TODO implement splash screen later
        return Container();
  },
), navigatorKey: NavigatorKeys.loginNavigatorKey,
        ),
      ),
    );
  }
}
