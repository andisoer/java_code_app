import 'dart:convert';

CreateOrderResult createOrderResultFromJson(String str) =>
    CreateOrderResult.fromJson(json.decode(str));

String createOrderResultToJson(CreateOrderResult data) =>
    json.encode(data.toJson());

class CreateOrderResult {
  CreateOrderResult({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  Data data;

  factory CreateOrderResult.fromJson(Map<String, dynamic> json) =>
      CreateOrderResult(
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.idOrder,
    required this.noStruk,
    required this.message,
  });

  int idOrder;
  String noStruk;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "message": message,
      };
}
