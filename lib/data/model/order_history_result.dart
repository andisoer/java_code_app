import 'dart:convert';

OrderHistoryResult orderHistoryResultFromJson(String str) =>
    OrderHistoryResult.fromJson(json.decode(str));

String orderHistoryResultToJson(OrderHistoryResult data) =>
    json.encode(data.toJson());

class OrderHistoryResult {
  OrderHistoryResult({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  List<MenuOverview> data;

  factory OrderHistoryResult.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResult(
        statusCode: json["status_code"],
        data: List<MenuOverview>.from(json["data"].map((x) => MenuOverview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MenuOverview {
  MenuOverview({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.menu,
  });

  int idOrder;
  String noStruk;
  String nama;
  int totalBayar;
  DateTime tanggal;
  int status;
  List<MenuHistory> menu;

  factory MenuOverview.fromJson(Map<String, dynamic> json) => MenuOverview(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: DateTime.parse(json["tanggal"]),
        status: json["status"],
        menu: List<MenuHistory>.from(
            json["menu"].map((x) => MenuHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "nama": nama,
        "total_bayar": totalBayar,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "status": status,
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class MenuHistory {
  MenuHistory({
    required this.idMenu,
    required this.kategori,
    required this.topping,
    required this.nama,
    required this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  int idMenu;
  String kategori;
  String topping;
  String nama;
  String foto;
  int? jumlah;
  String? harga;
  int total;
  String catatan;

  factory MenuHistory.fromJson(Map<String, dynamic> json) => MenuHistory(
        idMenu: json["id_menu"],
        kategori: json["kategori"],
        topping: json["topping"],
        nama: json["nama"],
        foto: json["foto"],
        jumlah: json["jumlah"],
        harga: json["harga"],
        total: json["total"],
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "kategori": kategori,
        "topping": topping,
        "nama": nama,
        "foto": foto,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        "catatan": catatan,
      };
}
