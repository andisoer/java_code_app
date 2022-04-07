import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/page/bottom_navigation_main.dart';
import 'package:java_code_app/page/check_location.dart';
import 'package:java_code_app/page/detail_menu.dart';
import 'package:java_code_app/page/detail_promo.dart';
import 'package:java_code_app/page/home.dart';
import 'package:java_code_app/page/login_page.dart';
import 'package:java_code_app/provider/auth_provider.dart';
import 'package:java_code_app/provider/location_provider.dart';
import 'package:java_code_app/provider/menu_detail_provider.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/provider/promo_detail_provider.dart';
import 'package:java_code_app/provider/promo_provider.dart';
import 'package:provider/provider.dart';

SharedPreferencesUtils preferences = SharedPreferencesUtils();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool internetConnected = false;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PromoProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => MenuProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => LocationProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: preferences.isLoggedIn()
            ? CheckLocationPage.routeName
            : LoginPage.routeName,
        routes: {
          BottomNavigationMain.routeName: (context) =>
              const BottomNavigationMain(),
          LoginPage.routeName: (context) => const LoginPage(),
          CheckLocationPage.routeName: (context) => const CheckLocationPage(),
          HomePage.routeName: (context) => const HomePage(),
          DetailMenuPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => MenuDetailProvider(
                  apiService: ApiService(),
                  menuId: ModalRoute.of(context)?.settings.arguments as int,
                ),
                child: const DetailMenuPage(),
              ),
          DetailPromoPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => PromoDetailProvider(
                  apiService: ApiService(),
                  promoId: ModalRoute.of(context)?.settings.arguments as int,
                ),
                child: const DetailPromoPage(),
              ),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        setState(() {
          internetConnected = true;
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          internetConnected = true;
        });
      } else if (result == ConnectivityResult.none) {
        setState(() {
          internetConnected = false;
        });
      } else {
        setState(() {
          internetConnected = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
