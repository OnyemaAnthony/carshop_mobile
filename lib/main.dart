import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/utilities/colors.dart';
import 'package:carshop_mobile/utilities/local_storage.dart';
import 'package:carshop_mobile/utilities/navigator_keys.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String accessToken = await LocalStorage.getString('access_token');
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {
  final String accessToken;
  const MyApp({super.key, required this.accessToken});
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
                AuthenticationBloc(accessToken)..add(AppStartedEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              brightness: Brightness.dark),
          home: accessToken.isEmpty
              ? const LoginScreen()
              : const BottomNavigationBarScreen(),
          navigatorKey: NavigatorKeys.loginNavigatorKey,
        ),
      ),
    );
  }
}
