import 'package:carshop_mobile/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:carshop_mobile/blocs/setting/setting_bloc.dart';
import 'package:carshop_mobile/screens/buttom_navigation_screen.dart';
import 'package:carshop_mobile/screens/login_screen.dart';
import 'package:carshop_mobile/utilities/configs.dart';
import 'package:carshop_mobile/utilities/constants.dart';
import 'package:carshop_mobile/utilities/navigator_keys.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  bool loaded = await DaynoConfig().load();

  if (!loaded) {
    throw Exception('Failed to load config');
  }

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCDGETeImjV37jyjyhpHImYg3I53r7GzDg",
        appId: "1:884863427065:web:e08a73b179e7939bbb1d28",
        messagingSenderId: "884863427065",
        projectId: "carshop-eee10",
      ),
    );
  }

  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
        supportedLocales:
            Constants.countriesFlag.map((language) => language.locale).toList(),
        startLocale: Constants.countriesFlag[0].locale,
        path: 'assets/translations',
        fallbackLocale: Constants.countriesFlag[0].locale,
        child: const MyApp()),
  );
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
            create: (BuildContext context) =>
                AuthenticationBloc()..add(AppStartedEvent()),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                SettingBloc()..add(LoadSettingEvent()),
          ),
        ],
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: state.language.locale,
              debugShowCheckedModeBanner: false,
              theme: state is ThemeState ? state.theme : null,
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationLoadingState) {
                    return UiUtilities.showMainLoader();
                  } else if (state is Authenticated) {
                    return const BottomNavigationBarScreen();
                  } else if (state is UnAuthenticated) {
                    return const LoginScreen();
                  }
                  return Container();
                },
              ),
              navigatorKey: NavigatorKeys.loginNavigatorKey,
            );
          },
        ),
      ),
    );
  }
}
