import 'package:java_code_app/data/model/voucher_result.dart';
import 'dart:convert';

VoucherDetailResult voucherDetailResultFromJson(String str) =>
    VoucherDetailResult.fromJson(json.decode(str));

String voucherDetailResultToJson(VoucherDetailResult data) =>
    json.encode(data.toJson());

class VoucherDetailResult {
  VoucherDetailResult({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  Voucher data;

  factory VoucherDetailResult.fromJson(Map<String, dynamic> json) =>
      VoucherDetailResult(
        statusCode: json["status_code"],
        data: Voucher.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data.toJson(),
      };
}
