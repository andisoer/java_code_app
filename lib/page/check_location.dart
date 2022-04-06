import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
                            width: MediaQuery.of(context).size.width * 1 / 2,
                            child: Text(
                              _currentAddress,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )),
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
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
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
