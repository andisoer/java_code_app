import 'package:flutter/material.dart';
import 'package:java_code_app/page/home.dart';
import 'package:java_code_app/page/order.dart';
import 'package:java_code_app/page/profile.dart';

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
                  label: 'Beranda'),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/images/sajen_selected_icon.png',
                  scale: 1.5,
                ),
                icon: Image.asset(
                  'assets/images/sajen_icon.png',
                  scale: 1.5,
                ),
                label: 'Pesanan',
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
                label: 'Profile',
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
