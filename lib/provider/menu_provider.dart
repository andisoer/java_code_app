import 'package:flutter/foundation.dart';
import 'package:java_code_app/data/api/api_service.dart';
import 'package:java_code_app/data/local/shared_preferences_utils.dart';
import 'package:java_code_app/data/model/menu_detail_result.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:collection/collection.dart';
import 'package:java_code_app/data/model/voucher_result.dart';

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

  //Tambah ke pesanan sementara ("cart")
  final List<Menu> _menuAddedList = [];
  List<Menu> get menuAddedList => _menuAddedList;

  late Voucher _voucherUsed;
  Voucher get voucherUsed => _voucherUsed;
  bool _isVoucherUsed = false;
  bool get isVoucherUsed => _isVoucherUsed;

  bool _isDiscountUsed = false;
  bool get isDiscountUsed => _isDiscountUsed;

  int menuTotal = 0;
  int priceTotal = 0;

  int dicountAmount = 0;
  int voucherAmount = 0;
  int totalPayment = 0;

  Future<dynamic> fetchMenu({required String type}) async {
    try {
      _state = MenuResourceState.loading;
      notifyListeners();

      SharedPreferencesUtils _preferences = SharedPreferencesUtils();
      await _preferences.init();
      var token = _preferences.getToken();

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

  addMenuCount(int menuId) {
    Menu? menu =
        _menuAddedList.firstWhereOrNull((item) => item.idMenu == menuId);

    Menu menuAdd = _findMenu(menuId);
    int index = _findMenuIndex(menuId);

    _menuResult.data[index].jumlah++;
    menuTotal += 1;
    priceTotal += _menuResult.data[index].harga;
    totalPayment = priceTotal;

    if (menu == null) {
      //Tambah baru
      menuAdd.jumlah = 1;
      _menuAddedList.add(menuAdd);
    }

    _countTotalPayment();

    notifyListeners();
  }

  removeMenuCount(int menuId) {
    Menu? menu =
        _menuAddedList.firstWhereOrNull((item) => item.idMenu == menuId);

    // Menu menuAdd = _findMenu(menuId);
    int index = _findMenuIndex(menuId);

    if (_menuResult.data[index].jumlah > 0) {
      _menuResult.data[index].jumlah--;
      menuTotal -= 1;
      priceTotal -= _menuResult.data[index].harga;
      totalPayment = priceTotal;
    }

    if (menu != null && menu.jumlah == 0) {
      //hapus menu dari pesanan sementara
      _menuAddedList.removeWhere((item) => item.idMenu == menuId);
    }

    _countTotalPayment();

    notifyListeners();
  }

  int _findMenuIndex(int menuId) {
    return _menuResult.data.indexWhere((item) => item.idMenu == menuId);
  }

  Menu _findMenu(int menuId) {
    return _menuResult.data.firstWhere((item) => item.idMenu == menuId);
  }

  void useVoucher(Voucher voucher) {
    _voucherUsed = voucher;
    _isVoucherUsed = true;

    _isDiscountUsed = false;

    _countTotalPayment();

    notifyListeners();
  }

  void unuseVoucher(Voucher voucher) {
    _isVoucherUsed = false;

    _countTotalPayment();

    notifyListeners();
  }

  void _countTotalPayment() {
    if (_isVoucherUsed) {
      totalPayment = priceTotal - _voucherUsed.nominal!;
    }
    if (totalPayment < 0) {
      totalPayment = 0;
    }

    notifyListeners();
  }

  void saveNote(int menuId, String note) {
    int index = _findMenuIndex(menuId);

    _menuResult.data[index].catatan = note;

    notifyListeners();
  }

  void chooseLevel(int menuId, Level level) {
    int index = _findMenuIndex(menuId);
    _menuResult.data[index].level = int.parse(level.keterangan);

    notifyListeners();
  }

  void chooseTopping(int menuId, int topping) {
    int index = _findMenuIndex(menuId);

    if (_menuResult.data[index].topping == null) {
      _menuResult.data[index].topping = [];
    }

    if (_menuResult.data[index].topping!.contains(topping)) {
      _menuResult.data[index].topping!
          .removeWhere((toppingId) => toppingId == topping);
    } else {
      _menuResult.data[index].topping?.add(topping);
    }

    notifyListeners();
  }
}
