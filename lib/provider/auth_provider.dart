import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/auth_result.dart';
import 'package:local_auth/local_auth.dart';

enum ResourceState { loading, success, error, none }

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;

  AuthProvider({required this.apiService});

  late AuthResult _authResult;
  AuthResult get authResult => _authResult;

  ResourceState _state = ResourceState.none;
  ResourceState get resourceState => _state;

  bool _isBioAuthenticated = false;
  bool get isBioAuthenticated => _isBioAuthenticated;

  Future<dynamic> login({
    required String password,
    required String nama,
    required String email,
    required bool isGoogle,
  }) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      final data = await apiService.login(
          nama: nama, password: password, email: email, isGoogle: isGoogle);

      if (data.statusCode == 200) {
        _state = ResourceState.success;

        SharedPreferencesUtils _preferences = SharedPreferencesUtils();
        await _preferences.init();
        _preferences.setPreferences(
          data.data.user,
          data.data.token,
        );

        notifyListeners();
        return _authResult = data;
      } else {
        _state = ResourceState.error;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }

  Future<void> authenticate() async {
    var localAuth = LocalAuthentication();
    _isBioAuthenticated = await localAuth.authenticate(
      localizedReason: 'Autentikasi untuk melakukan checkout!',
      biometricOnly: true,
    );

    notifyListeners();
  }
}

Future<String> getUserPin() async {
  SharedPreferencesUtils _preferences = SharedPreferencesUtils();
  await _preferences.init();
  var pin = _preferences.getUserPreferences().pin;

  return pin!;
}
