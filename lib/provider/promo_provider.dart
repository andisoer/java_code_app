import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/promo_result.dart';

enum ResourceState { loading, hasData, error, noData }

class PromoProvider extends ChangeNotifier {
  final ApiService apiService;

  PromoProvider({required this.apiService}) {
    _fetchPromo();
  }

  late PromoResult _promoResult;
  PromoResult get promoResult => _promoResult;

  late ResourceState _state;
  ResourceState get resourceState => _state;

  Future<dynamic> _fetchPromo() async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();

      print(token);

      final data = await apiService.fetchPromo(token: token);
      if (data.data.isNotEmpty) {
        _state = ResourceState.hasData;
        notifyListeners();
        return _promoResult = data;
      } else {
        _state = ResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }
}
