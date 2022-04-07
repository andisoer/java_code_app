import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:java_code_app/page/bottom_navigation_main.dart';
import 'package:java_code_app/page/home.dart';
import 'package:java_code_app/provider/location_provider.dart';
import 'package:provider/provider.dart';

class CheckLocationPage extends StatefulWidget {
  static const routeName = 'check_location';

  const CheckLocationPage({Key? key}) : super(key: key);

  @override
  State<CheckLocationPage> createState() => _CheckLocationPageState();
}

class _CheckLocationPageState extends State<CheckLocationPage> {
  Position? _currentPosition;
  String _currentAddress = '-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(36),
          child: Stack(
            children: [
              Image.asset('assets/images/pattern_2.png'),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Mencari Lokasimu...',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(129, 30, 30, 30),
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 36),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/map.png',
                                scale: 1.1,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/map_marker.png',
                                  scale: 1.1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 36),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          child: Consumer<LocationProvider>(
                            builder: (context, state, _) {
                              if (state.address != null) {
                                WidgetsBinding.instance?.addPostFrameCallback(
                                  (timeStamp) {
                                    Navigator.popAndPushNamed(
                                      context,
                                      BottomNavigationMain.routeName,
                                    );
                                  },
                                );
                                return Text(
                                  state.address!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                );
                              } else {
                                return Text(
                                  '-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  _getLocation() {
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        _getLocation();
      },
    );
  }
}
