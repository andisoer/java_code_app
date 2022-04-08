import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum ResourceState { loading, hasData, error, noData }

class LocationProvider extends ChangeNotifier {
  Position? _position;
  String? _address;
  String? get address => _address;

  Future<void> getCurrentLocation() async {
    try {
      Geolocator geolocator = Geolocator();

      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      _position = currentPosition;
      await _getAddressFromLatLng();
    } catch (e) {
      print(e);
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _position!.latitude, _position!.longitude);

      Placemark place = placemarks[0];

      _address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
