import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/model/menu_detail_result.dart';
import 'package:java_code_app/main.dart';

enum ResourceState { loading, hasData, error, noData }

class MenuDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  MenuDetailProvider({required this.apiService, required int menuId}) {
    _fetchMenuDetail(id: menuId);
  }

  late MenuDetailResult _menuDetailResult;
  MenuDetailResult get menuDetailResult => _menuDetailResult;

  late ResourceState _state;
  ResourceState get resourceState => _state;

  Future<dynamic> _fetchMenuDetail({required int id}) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      var token = preferences.getToken();
      final data = await apiService.fetchMenuDetail(menuId: id, token: token);
      if (data.statusCode == 200) {
        _state = ResourceState.hasData;
        notifyListeners();
        return _menuDetailResult = data;
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
