import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/profile_result.dart';

enum ResourceState { loading, success, error, none }

class ProfileProvider extends ChangeNotifier {
  final ApiService apiService;

  ProfileProvider({required this.apiService}) {
    fetchUserProfile();
    fetchDeviceInfo();
  }

  late ProfileResult _profileResult;
  ProfileResult get profileResult => _profileResult;

  ResourceState _state = ResourceState.none;
  ResourceState get resourceState => _state;

  String _deviceInfo = '-';
  String get deviceInfo => _deviceInfo;

  Future<dynamic> fetchUserProfile() async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data = await apiService.fetchUserProfile(token: token, id: userId!);
      if (data.statusCode == 200) {
        _state = ResourceState.success;
        notifyListeners();
        return _profileResult = data;
      } else {
        _state = ResourceState.none;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }

  Future<String> fetchDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var androidModel = '-';
    if (androidInfo.model != null) {
      androidModel = androidInfo.model!;
    }
 
    _deviceInfo = androidModel;
    log(_deviceInfo);
    notifyListeners();
    return _deviceInfo;
  }
}
