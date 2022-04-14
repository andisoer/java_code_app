import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/order_history_result.dart';

enum ResourceState { loading, hasData, error, noData }

class OrderHistoryProvider extends ChangeNotifier {
  final ApiService apiService;

  OrderHistoryProvider({required this.apiService}) {
    fetchOrderHistory();
  }

  late OrderHistoryResult _orderHistoryResult;
  OrderHistoryResult get orderHistoryResult => _orderHistoryResult;

  late ResourceState _state;
  ResourceState get resourceState => _state;

  Future<dynamic> fetchOrderHistory() async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data =
          await apiService.fetchOrderHistoryByUser(token: token, id: userId!);

      print(data);

      if (data.data.isNotEmpty) {
        _state = ResourceState.hasData;
        notifyListeners();
        return _orderHistoryResult = data;
      } else {
        _state = ResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _state = ResourceState.error;
      notifyListeners();
    }
  }
}
