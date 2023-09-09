import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/utilities/current_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/map/map_bloc.dart';
import 'blocs/map/map_events.dart';
import 'utilities/colors.dart';
import 'utilities/navigator_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CurrentUser.loadCurrentUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              brightness: Brightness.dark),
          home: CurrentUser.uId == null
              ? const LoginScreen()
              : const BottomNavigationBarScreen(),
          navigatorKey: NavigatorKeys.loginNavigatorKey,
        ),
      ),
    );
  }
}
