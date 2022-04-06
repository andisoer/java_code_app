import 'package:java_code_app/data/model/menu_result.dart';
import 'dart:convert';

MenuDetailResult menuDetailResultFromJson(String str) => MenuDetailResult.fromJson(json.decode(str));

String menuDetailResultToJson(MenuDetailResult data) => json.encode(data.toJson());

class MenuDetailResult {
    MenuDetailResult({
        required this.statusCode,
        required this.data,
    });

    int statusCode;
    Data data;

    factory MenuDetailResult.fromJson(Map<String, dynamic> json) => MenuDetailResult(
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
        required this.menu,
        required this.topping,
        required this.level,
    });

    Menu menu;
    List<dynamic> topping;
    List<Level> level;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        menu: Menu.fromJson(json["menu"]),
        topping: List<dynamic>.from(json["topping"].map((x) => x)),
        level: List<Level>.from(json["level"].map((x) => Level.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu": menu.toJson(),
        "topping": List<dynamic>.from(topping.map((x) => x)),
        "level": List<dynamic>.from(level.map((x) => x.toJson())),
    };
}

class Level {
    Level({
        required this.idDetail,
        required this.idMenu,
        required this.keterangan,
        required this.type,
        required this.harga,
    });

    int idDetail;
    int idMenu;
    String keterangan;
    String type;
    int harga;

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        idDetail: json["id_detail"],
        idMenu: json["id_menu"],
        keterangan: json["keterangan"],
        type: json["type"],
        harga: json["harga"],
    );

    Map<String, dynamic> toJson() => {
        "id_detail": idDetail,
        "id_menu": idMenu,
        "keterangan": keterangan,
        "type": type,
        "harga": harga,
    };
}
