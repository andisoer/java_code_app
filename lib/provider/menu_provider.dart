import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/main.dart';

enum MenuResourceState { loading, hasData, error, noData }

class MenuProvider extends ChangeNotifier {
  final ApiService apiService;

  MenuProvider({required this.apiService, String type = 'all'}) {
    fetchMenu(type: type);
  }

  late MenuResult _menuResult;
  MenuResult get menuResult => _menuResult;

  late MenuResourceState _state;
  MenuResourceState get resourceState => _state;

  Future<dynamic> fetchMenu({required String type}) async {
    try {
      _state = MenuResourceState.loading;
      notifyListeners();

      var token = preferences.getToken();

      late MenuResult data;
      if (type == 'all') {
        data = await apiService.fetchMenuAll(token: token);
      } else {
        data = await apiService.fetchMenuByCategory(
          token: token,
          category: type,
        );
      }

      if (data.data.isNotEmpty) {
        _state = MenuResourceState.hasData;
        notifyListeners();
        return _menuResult = data;
      } else {
        _state = MenuResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = MenuResourceState.error;
      notifyListeners();
    }
  }
}
