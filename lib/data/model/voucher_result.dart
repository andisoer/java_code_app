import 'dart:convert';

VoucherResult voucherResultFromJson(String str) =>
    VoucherResult.fromJson(json.decode(str));

String voucherResultToJson(VoucherResult data) => json.encode(data.toJson());

class VoucherResult {
  VoucherResult({
    required this.data,
    required this.statusCode,
  });

  int statusCode;
  List<Voucher> data;

  factory VoucherResult.fromJson(Map<String, dynamic> json) => VoucherResult(
        statusCode: json["status_code"],
        data: List<Voucher>.from(json["data"].map((x) => Voucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Voucher {
  Voucher({
    required this.idVoucher,
    required this.nama,
    required this.idUser,
    required this.namaUser,
    required this.nominal,
    required this.infoVoucher,
    required this.periodeMulai,
    required this.periodeSelesai,
    required this.type,
    required this.status,
    required this.catatan,
  });

  int idVoucher;
  String nama;
  int idUser;
  String namaUser;
  int nominal;
  String infoVoucher;
  int periodeMulai;
  int periodeSelesai;
  int type;
  int status;
  String catatan;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        idVoucher: json["id_voucher"],
        nama: json["nama"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        nominal: json["nominal"],
        infoVoucher: json["info_voucher"],
        periodeMulai: json["periode_mulai"],
        periodeSelesai: json["periode_selesai"],
        type: json["type"],
        status: json["status"],
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_voucher": idVoucher,
        "nama": nama,
        "id_user": idUser,
        "nama_user": namaUser,
        "nominal": nominal,
        "info_voucher": infoVoucher,
        "periode_mulai": periodeMulai,
        "periode_selesai": periodeSelesai,
        "type": type,
        "status": status,
        "catatan": catatan,
      };
}
