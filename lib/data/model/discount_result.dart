import 'dart:convert';

DiscountResult discountResultFromJson(String str) => DiscountResult.fromJson(json.decode(str));

String discountResultToJson(DiscountResult data) => json.encode(data.toJson());

class DiscountResult {
    DiscountResult({
        required this.statusCode,
        required this.data,
    });

    int statusCode;
    List<Datum> data;

    factory DiscountResult.fromJson(Map<String, dynamic> json) => DiscountResult(
        statusCode: json["status_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.idDiskon,
        required this.idUser,
        required this.namaUser,
        required this.nama,
        required this.diskon,
    });

    int idDiskon;
    int idUser;
    String namaUser;
    String nama;
    int diskon;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idDiskon: json["id_diskon"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        nama: json["nama"],
        diskon: json["diskon"],
    );

    Map<String, dynamic> toJson() => {
        "id_diskon": idDiskon,
        "id_user": idUser,
        "nama_user": namaUser,
        "nama": nama,
        "diskon": diskon,
    };
}
