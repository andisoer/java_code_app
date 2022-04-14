import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/page/bottom_navigation_main.dart';
import 'package:java_code_app/page/check_location.dart';
import 'package:java_code_app/page/checkout.dart';
import 'package:java_code_app/page/detail_menu.dart';
import 'package:java_code_app/page/detail_order.dart';
import 'package:java_code_app/page/detail_promo.dart';
import 'package:java_code_app/page/detail_voucher.dart';
import 'package:java_code_app/page/home.dart';
import 'package:java_code_app/page/login_page.dart';
import 'package:java_code_app/page/no_internet.dart';
import 'package:java_code_app/page/voucher.dart';
import 'package:java_code_app/provider/auth_provider.dart';
import 'package:java_code_app/provider/discount_provider.dart';
import 'package:java_code_app/provider/location_provider.dart';
import 'package:java_code_app/provider/menu_detail_provider.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/provider/order_history_detail_provider.dart';
import 'package:java_code_app/provider/order_history_provider.dart';
import 'package:java_code_app/provider/order_provider.dart';
import 'package:java_code_app/provider/promo_detail_provider.dart';
import 'package:java_code_app/provider/promo_provider.dart';
import 'package:java_code_app/provider/voucher_detail_provider.dart';
import 'package:java_code_app/provider/voucher_provider.dart';
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
        ChangeNotifierProvider(
          create: (_) => VoucherProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DiscountProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderHistoryProvider(
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
          CheckoutPage.routeName: (context) => const CheckoutPage(),
          NoInternetPage.routeName: (context) => const NoInternetPage(),
          VoucherPage.routeName: (context) => const VoucherPage(),
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
          DetailVoucherPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => VoucherDetailProvider(
                  apiService: ApiService(),
                  voucherId: ModalRoute.of(context)?.settings.arguments as int,
                ),
                child: const DetailVoucherPage(),
              ),
          DetailOrderPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => OrderHistoryDetailProvider(
                  apiService: ApiService(),
                  orderId: ModalRoute.of(context)?.settings.arguments as int,
                ),
                child: const DetailOrderPage(),
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
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
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
