import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/voucher_detail_result.dart';

enum VoucherDetailResourceState { loading, hasData, error, noData }

class VoucherDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  VoucherDetailProvider({required this.apiService, required int voucherId}) {
    _fetchVoucherDetail(id: voucherId);
  }

  late VoucherDetailResult _voucherDetailResult;
  VoucherDetailResult get voucherResult => _voucherDetailResult;

  late VoucherDetailResourceState _state;
  VoucherDetailResourceState get resourceState => _state;

  Future<dynamic> _fetchVoucherDetail({required int id}) async {
    try {
      _state = VoucherDetailResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();

      final data = await apiService.fetchVoucherDetail(id: id, token: token);
      if (data.statusCode == 200) {
        _state = VoucherDetailResourceState.hasData;
        notifyListeners();
        return _voucherDetailResult = data;
      } else {
        _state = VoucherDetailResourceState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = VoucherDetailResourceState.error;
      notifyListeners();
    }
  }
}
