import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/order_history_result.dart';

enum ResourceState { loading, hasData, error, noData }
enum OrderStatus { inQueue, inPrepare, canPickup, pickedUp, canceled }

extension OrderStatusExtension on OrderStatus {
  int get status {
    switch (this) {
      case OrderStatus.inQueue:
        return 0;
      case OrderStatus.inPrepare:
        return 1;
      case OrderStatus.canPickup:
        return 2;
      case OrderStatus.pickedUp:
        return 3;
      case OrderStatus.canceled:
        return 4;
      default:
        return 0;
    }
  }
}

class OrderHistoryProvider extends ChangeNotifier {
  final ApiService apiService;

  OrderHistoryProvider({required this.apiService}) {
    fetchOrderListByStatus(status: OrderStatus.inQueue.status);
    fetchOrderHistory();
  }

  late OrderHistoryResult _orderList;
  OrderHistoryResult get orderList => _orderList;

  late OrderHistoryResult _orderHistory;
  // OrderHistoryResult get orderHistory => _orderHistory;

  List<dynamic> orderHistoryFiltered = [];

  late ResourceState _state;
  ResourceState get resourceState => _state;

  // final List<dynamic> _orderHistories = [];
  // List<dynamic> get orderHistories => _orderHistories;

  int offset = 0;
  int limit = 10;

  Future<dynamic> fetchOrderListByStatus({required int status}) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data = await apiService.fetchOrderListByUserAndStatus(
        token: token,
        id: userId!,
        status: status,
      );

      if (data.data.isNotEmpty) {
        _orderList = data;

        _state = ResourceState.hasData;

        notifyListeners();

        // fetchPagingOrderHistory();

        return _orderList;
      } else {
        _state = ResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }

  Future<dynamic> fetchOrderHistory() async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data = await apiService.fetchOrderHistory(
        token: token,
        id: userId!,
      );

      if (data.data.isNotEmpty) {
        _state = ResourceState.hasData;

        _orderHistory = data;

        orderHistoryFiltered = _orderHistory.data;

        notifyListeners();

        return _orderHistory;
      } else {
        _state = ResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
    }
  }

  void filterOrderHistory(String statusText) {
    var status = 0;
    if (statusText == "Selesai") {
      status = OrderStatus.pickedUp.status;
    } else if (statusText == "Dibatalkan") {
      status = OrderStatus.canceled.status;
    } else {
      status = 0;
    }

    if (status == 0) {
      orderHistoryFiltered = _orderHistory.data;
      notifyListeners();
    }

    var filteredOrder = [];
    if (status != 0) {
      for (var item in _orderHistory.data) {
        var menuItem = item as MenuOverview;
        if (item.status == status) {
          filteredOrder.add(menuItem);
        }
      }
      orderHistoryFiltered = filteredOrder;

      notifyListeners();
    }
  }
  // void fetchPagingOrderHistory() {
  //   var pagedList = _orderList.data.getRange(offset, limit - 1);

  //   _orderHistories.addAll(pagedList);

  //   offset += 10;
  //   limit += 10;

  //   notifyListeners();
  // }
}
