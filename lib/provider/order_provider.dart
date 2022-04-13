import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/auth_result.dart';
import 'package:java_code_app/data/model/create_order_result.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:local_auth/local_auth.dart';

enum ResourceState { loading, success, error, none }

class OrderProvider extends ChangeNotifier {
  final ApiService apiService;

  OrderProvider({required this.apiService});

  late CreateOrderResult _orderResult;
  CreateOrderResult get orderResult => _orderResult;

  ResourceState _state = ResourceState.none;
  ResourceState get resourceState => _state;

  Future<dynamic> createOrder({
    int? voucherId,
    int? discount,
    required int totalPayment,
    required List<Menu> menuAddedList,
  }) async {
    print(totalPayment);
    try {
      _state = ResourceState.loading;
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
        _state = ResourceState.success;

        notifyListeners();
        return _orderResult = data;
      } else {
        _state = ResourceState.error;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }
}
