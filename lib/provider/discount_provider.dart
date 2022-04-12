import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/discount_result.dart';

enum DiscountResourceState { loading, hasData, error, noData }

class DiscountProvider extends ChangeNotifier {
  final ApiService apiService;

  DiscountProvider({required this.apiService}) {
    _fetchDiscountsByUserId();
  }

  late DiscountResult _discountResult;
  DiscountResult get discountResult => _discountResult;

  late DiscountResourceState _state;
  DiscountResourceState get resourceState => _state;

  Future<dynamic> _fetchDiscountsByUserId() async {
    try {
      _state = DiscountResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data = await apiService.fetchDiscountByUserId(
        token: token,
        userId: userId!,
      );

      if (data.data.isNotEmpty) {
        _state = DiscountResourceState.hasData;
        notifyListeners();
        return _discountResult = data;
      } else {
        _state = DiscountResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = DiscountResourceState.error;
      notifyListeners();
    }
  }
}
