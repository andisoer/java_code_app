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

  final List<dynamic> _orderHistories = [];
  List<dynamic> get orderHistories => _orderHistories;

  int offset = 0;
  int limit = 10;

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

      if (data.data.isNotEmpty) {
        _state = ResourceState.hasData;
        notifyListeners();

        _orderHistoryResult = data;

        fetchPagingOrderHistory();

        return _orderHistoryResult;
      } else {
        _state = ResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }

  void fetchPagingOrderHistory() {
    var pagedList = _orderHistoryResult.data.getRange(offset, limit - 1);

    _orderHistories.addAll(pagedList);

    offset += 10;
    limit += 10;

    notifyListeners();
  }
}
