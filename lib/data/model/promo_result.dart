import 'dart:convert';

PromoResult promoResultFromJson(String str) => PromoResult.fromJson(json.decode(str));

String promoResultToJson(PromoResult data) => json.encode(data.toJson());

class PromoResult {
    PromoResult({
        required this.statusCode,
        required this.data,
    });

    int statusCode;
    List<Promo> data;

    factory PromoResult.fromJson(Map<String, dynamic> json) => PromoResult(
        statusCode: json["status_code"],
        data: List<Promo>.from(json["data"].map((x) => Promo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Promo {
    Promo({
        required this.idPromo,
        required this.type,
        required this.nama,
        required this.diskon,
        required this.nominal,
        required this.kadaluarsa,
        required this.syaratKetentuan,
        required this.foto,
    });

    int? idPromo;
    String? type;
    String? nama;
    int? diskon;
    int? nominal;
    int? kadaluarsa;
    String? syaratKetentuan;
    String? foto;

    factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        idPromo: json["id_promo"],
        type: json["type"],
        nama: json["nama"],
        diskon: json["diskon"] == null ? null : json["diskon"],
        nominal: json["nominal"],
        kadaluarsa: json["kadaluarsa"],
        syaratKetentuan: json["syarat_ketentuan"],
        foto: json["foto"] == null ? null : json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id_promo": idPromo,
        "type": type,
        "nama": nama,
        "diskon": diskon == null ? null : diskon,
        "nominal": nominal,
        "kadaluarsa": kadaluarsa,
        "syarat_ketentuan": syaratKetentuan,
        "foto": foto == null ? null : foto,
    };
}
