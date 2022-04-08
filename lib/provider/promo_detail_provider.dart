import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/promo_detail_result.dart';

enum ResourceState { loading, hasData, error, noData }

class PromoDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  PromoDetailProvider({required this.apiService, required int promoId}) {
    _fetchPromDetail(id: promoId);
  }

  late PromoDetailResult _promoDetailResult;
  PromoDetailResult get promoResult => _promoDetailResult;

  late ResourceState _state;
  ResourceState get resourceState => _state;

  Future<dynamic> _fetchPromDetail({required int id}) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();

      final data = await apiService.fetchPromoDetail(id: id, token: token);
      if (data.statusCode == 200) {
        _state = ResourceState.hasData;
        notifyListeners();
        return _promoDetailResult = data;
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
