import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/page/checkout.dart';
import 'package:java_code_app/page/home.dart';
import 'package:java_code_app/page/order.dart';
import 'package:java_code_app/page/profile.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:provider/provider.dart';

class BottomNavigationMain extends StatefulWidget {
  static const routeName = 'bottomNavigationMain';

  const BottomNavigationMain({Key? key}) : super(key: key);

  @override
  State<BottomNavigationMain> createState() => _BottomNavigationMainState();
}

class _BottomNavigationMainState extends State<BottomNavigationMain> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    OrderPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: Consumer<MenuProvider>(
        builder: (context, state, _) {
          return Visibility(
            visible: state.menuAddedList.isNotEmpty ? true : false,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, CheckoutPage.routeName);
              },
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              backgroundColor: primaryColor,
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 46, 46, 46),
            unselectedItemColor: const Color.fromARGB(255, 194, 194, 194),
            selectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/images/home_selected_icon.png',
                  scale: 1.5,
                ),
                icon: Image.asset(
                  'assets/images/home_icon.png',
                  scale: 1.5,
                ),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/images/sajen_selected_icon.png',
                  scale: 1.5,
                ),
                icon: Image.asset(
                  'assets/images/sajen_icon.png',
                  scale: 1.5,
                ),
                label: 'order'.tr(),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/images/profile_selected_icon.png',
                  scale: 1.5,
                ),
                icon: Image.asset(
                  'assets/images/profile_icon.png',
                  scale: 1.5,
                ),
                label: 'profile'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
