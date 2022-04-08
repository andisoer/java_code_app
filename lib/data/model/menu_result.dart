import 'dart:convert';

MenuResult menuResultFromJson(String str) => MenuResult.fromJson(json.decode(str));

String menuResultToJson(MenuResult data) => json.encode(data.toJson());

class MenuResult {
    MenuResult({
        required this.statusCode,
        required this.data,
    });

    int statusCode;
    List<Menu> data;

    factory MenuResult.fromJson(Map<String, dynamic> json) => MenuResult(
        statusCode: json["status_code"],
        data: List<Menu>.from(json["data"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Menu {
    Menu({
        required this.idMenu,
        required this.nama,
        required this.kategori,
        required this.harga,
        required this.deskripsi,
        required this.foto,
        required this.status,
        
        //Tambah pesanan
        this.jumlah = 0,
        this.catatan = '',
        this.level,
        this.topping
    });

    int idMenu;
    String nama;
    String kategori;
    int harga;
    String deskripsi;
    String foto;
    int status;

    //Tambah pesanan
    int jumlah;
    String catatan;
    int? level;
    List<int>? topping;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idMenu: json["id_menu"],
        nama: json["nama"],
        kategori: json["kategori"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        foto: json["foto"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "nama": nama,
        "kategori": kategori,
        "harga": harga,
        "deskripsi": deskripsi,
        "foto": foto,
        "status": status,
    };
}
