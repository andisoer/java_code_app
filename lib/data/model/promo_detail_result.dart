import 'dart:convert';

import 'package:java_code_app/data/model/promo_result.dart';

PromoDetailResult promoDetailResultFromJson(String str) => PromoDetailResult.fromJson(json.decode(str));

String promoDetailResultToJson(PromoDetailResult data) => json.encode(data.toJson());

class PromoDetailResult {
    PromoDetailResult({
        required this.statusCode,
        required this.promo,
    });

    int statusCode;
    Promo promo;

    factory PromoDetailResult.fromJson(Map<String, dynamic> json) => PromoDetailResult(
        statusCode: json["status_code"],
        promo: Promo.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": promo.toJson(),
    };
}