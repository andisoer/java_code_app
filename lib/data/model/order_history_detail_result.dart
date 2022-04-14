import 'package:java_code_app/data/model/order_history_result.dart';
import 'dart:convert';

OrderHistoryDetailResult orderHistoryDetailResultFromJson(String str) =>
    OrderHistoryDetailResult.fromJson(json.decode(str));

class OrderHistoryDetailResult {
  OrderHistoryDetailResult({
    required this.statusCode,
    required this.data,
  });
 
  int statusCode;
  Data data;

  factory OrderHistoryDetailResult.fromJson(Map<String, dynamic> json) =>
      OrderHistoryDetailResult(
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.order,
    required this.detail,
  });

  Order order;
  List<MenuHistory> detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: Order.fromJson(json["order"]),
        detail: List<MenuHistory>.from(
            json["detail"].map((x) => MenuHistory.fromJson(x))),
      );
}

class Order {
  Order({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.idVoucher,
    required this.namaVoucher,
    required this.diskon,
    required this.potongan,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
  });

  int idOrder;
  String noStruk;
  String nama;
  int idVoucher;
  String? namaVoucher;
  int diskon;
  int potongan;
  int totalBayar;
  String tanggal;
  int status;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        idVoucher: json["id_voucher"],
        namaVoucher: json["nama_voucher"],
        diskon: json["diskon"],
        potongan: json["potongan"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"],
        status: json["status"],
      );
}
