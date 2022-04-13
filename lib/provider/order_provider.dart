import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/create_order_result.dart';
import 'package:java_code_app/data/model/menu_result.dart';

enum OrderResourceState { loading, success, error, none }

class OrderProvider extends ChangeNotifier {
  final ApiService apiService;

  OrderProvider({required this.apiService});

  late CreateOrderResult _orderResult;
  CreateOrderResult get orderResult => _orderResult;

  OrderResourceState _state = OrderResourceState.none;
  OrderResourceState get resourceState => _state;

  Future<dynamic> createOrder({
    int? voucherId,
    int? discount,
    required int totalPayment,
    required List<Menu> menuAddedList,
  }) async {
    try {
      _state = OrderResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data = await apiService.createOrder(
        discount: discount,
        voucherId: voucherId,
        menuAddedList: menuAddedList,
        token: token,
        totalPayment: totalPayment,
        userId: userId!,
      );

      if (data.statusCode == 200) {
        _state = OrderResourceState.success;

        notifyListeners();
        return _orderResult = data;
      } else {
        _state = OrderResourceState.error;
        notifyListeners();
      }
    } catch (e) {
      _state = OrderResourceState.error;
      notifyListeners();
    }
  }
}
