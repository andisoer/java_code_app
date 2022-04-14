import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/order_history_detail_result.dart';

enum ResourceState { loading, hasData, error, noData }

class OrderHistoryDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  OrderHistoryDetailProvider({required this.apiService, required int orderId}) {
    _fetchOrderHistoryDetail(orderId: orderId);
  }

  late OrderHistoryDetailResult _orderHistoryDetailResult;
  OrderHistoryDetailResult get orderHistoryDetailResult =>
      _orderHistoryDetailResult;

  late ResourceState _state;
  ResourceState get resourceState => _state;

  bool _isVoucherUsed = false;

  int menuTotal = 0;
  int priceTotal = 0;

  int totalPayment = 0;
  int voucherNominal = 0;

  int totalDiscountNominal = 0;

  Future<dynamic> _fetchOrderHistoryDetail({required int orderId}) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();

      final data =
          await apiService.fetchOrderHistoryDetail(id: orderId, token: token);

      if (data.statusCode == 200) {
        _state = ResourceState.hasData;

        notifyListeners();
        _orderHistoryDetailResult = data;

        

        return _orderHistoryDetailResult;
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