import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/promo_result.dart';
import 'package:java_code_app/data/model/voucher_result.dart';

enum ResourceState { loading, hasData, error, noData }

class VoucherProvider extends ChangeNotifier {
  final ApiService apiService;

  VoucherProvider({required this.apiService}) {
    _fetchVouchersByUserId();
  }

  late VoucherResult _voucherResult;
  VoucherResult get voucherResult => _voucherResult;

  late ResourceState _state;
  ResourceState get resourceState => _state;

  Future<dynamic> _fetchVouchersByUserId() async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();
      var userId = _preferences.getUserPreferences().idUser;

      final data = await apiService.fetchVouchersByUserId(
        token: token,
        userId: userId!,
      );

      if (data.data.isNotEmpty) {
        _state = ResourceState.hasData;
        notifyListeners();
        return _voucherResult = data;
      } else {
        print(data);
        _state = ResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _state = ResourceState.error;
      notifyListeners();
    }
  }

  void selectVoucher(index) {
    voucherResult.data[index].isSelected =
        !voucherResult.data[index].isSelected;

    notifyListeners();
  }
}
