import 'dart:convert';

import 'package:java_code_app/data/model/auth_result.dart';
import 'package:java_code_app/data/model/create_order_result.dart';
import 'package:java_code_app/data/model/discount_result.dart';
import 'package:java_code_app/data/model/menu_detail_result.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/data/model/order_history_detail_result.dart';
import 'package:java_code_app/data/model/order_history_result.dart';
import 'package:java_code_app/data/model/profile_result.dart';
import 'package:java_code_app/data/model/promo_detail_result.dart';
import 'package:java_code_app/data/model/promo_result.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/data/model/voucher_detail_result.dart';
import 'package:java_code_app/data/model/voucher_result.dart';

class ApiService {
  static const _baseUrl = "https://javacode.landa.id/api/";

  Future<PromoResult> fetchPromo({
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'promo/all'),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return PromoResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch promo');
    }
  }

  Future<PromoDetailResult> fetchPromoDetail(
      {required int id, required String token}) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'promo/detail/' + id.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return PromoDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch promo');
    }
  }

  Future<AuthResult> login({
    required String nama,
    required String password,
    required bool isGoogle,
    required String email,
  }) async {
    String body = "";

    //Check if login using google
    if (isGoogle) {
      body = jsonEncode(<String, String>{
        'is_google': "is_google",
        'email': email,
        'nama': nama,
      });
    } else {
      body = jsonEncode(<String, String>{'email': email, 'password': password});
    }

    final response = await http.post(
      Uri.parse(_baseUrl + 'auth/login'),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return AuthResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<MenuResult> fetchMenuAll({
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'menu/all'),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return MenuResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch promo');
    }
  }

  Future<MenuResult> fetchMenuByCategory(
      {required String token, required String category}) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'menu/kategori/' + category),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return MenuResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch promo');
    }
  }

  Future<MenuDetailResult> fetchMenuDetail(
      {required String token, required int menuId}) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'menu/detail/' + menuId.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return MenuDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch promo');
    }
  }

  Future<VoucherResult> fetchVouchersByUserId({
    required String token,
    required int userId,
  }) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'voucher/user/' + userId.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return VoucherResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch voucher');
    }
  }

  Future<VoucherDetailResult> fetchVoucherDetail(
      {required int id, required String token}) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'voucher/detail/' + id.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return VoucherDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch voucher detail');
    }
  }

  Future<DiscountResult> fetchDiscountByUserId({
    required String token,
    required int userId,
  }) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'diskon/user/' + userId.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return DiscountResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch voucher');
    }
  }

  Future<CreateOrderResult> createOrder({
    required String token,
    required int userId,
    int? voucherId = 0,
    int? discount = 0,
    required int totalPayment,
    required List<Menu> menuAddedList,
  }) async {
    List<dynamic> menu = [];
    for (var _menu in menuAddedList) {
      menu.add({
        'id_menu': _menu.idMenu,
        'harga': _menu.harga,
        'level': _menu.level,
        'topping': _menu.topping,
        'jumlah': _menu.jumlah
      });
    }

    var body = jsonEncode(<String, dynamic>{
      'order': {
        'id_user': userId,
        'id_voucher': voucherId,
        'potongan': discount,
        'total_bayar': totalPayment
      },
      'menu': menu
    });

    final response = await http.post(
      Uri.parse(_baseUrl + 'order/add'),
      headers: {"token": token, "Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return CreateOrderResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<OrderHistoryResult> fetchOrderListByUserAndStatus({
    required int id,
    required String token,
    required int status,
  }) async {
    final response = await http.get(
      Uri.parse(
        _baseUrl + 'order/status/' + id.toString() + '/' + status.toString(),
      ),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return OrderHistoryResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch order histories');
    }
  }

  Future<OrderHistoryResult> fetchOrderHistory({
    required int id,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(
        _baseUrl + 'order/history/' + id.toString(),
      ),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return OrderHistoryResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch order histories');
    }
  }

  Future<OrderHistoryDetailResult> fetchOrderHistoryDetail({
    required int id,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'order/detail/' + id.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return OrderHistoryDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch order history detail');
    }
  }

  Future<ProfileResult> fetchUserProfile({
    required int id,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(_baseUrl + 'user/detail/' + id.toString()),
      headers: {
        "token": token,
      },
    );

    if (response.statusCode == 200) {
      return ProfileResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch detail profile');
    }
  }

  Future<ProfileResult> updateProfile({
    required int id,
    required String token,
    required String key,
    required dynamic value,
  }) async {
    var body = jsonEncode(<String, dynamic>{key: value});

    final response = await http.post(
      Uri.parse(_baseUrl + 'user/update/' + id.toString()),
      headers: {"token": token, "Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return ProfileResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch update profile!');
    }
  }

  Future<ProfileResult> updateProfilePhoto({
    required int id,
    required String token,
    required String image,
  }) async {
    var body = jsonEncode(<String, dynamic>{
      "foto": image,
    });

    final response = await http.post(
      Uri.parse(_baseUrl + 'user/profil/' + id.toString()),
      headers: {"token": token, "Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return ProfileResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch update profile!');
    }
  }
}
