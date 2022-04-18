import 'dart:convert';

ProfileResult profileResultFromJson(String str) =>
    ProfileResult.fromJson(json.decode(str));

String profileResultToJson(ProfileResult data) => json.encode(data.toJson());

class ProfileResult {
  ProfileResult({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  Data data;

  factory ProfileResult.fromJson(Map<String, dynamic> json) => ProfileResult(
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
    required this.idUser,
    required this.nama,
    required this.email,
    required this.tglLahir,
    required this.alamat,
    required this.telepon,
    required this.foto,
    required this.ktp,
    required this.pin,
    required this.status,
    required this.rolesId,
    required this.roles,
  });

  int? idUser;
  String? nama;
  String? email;
  String? tglLahir;
  String? alamat;
  String? telepon;
  String? foto;
  String? ktp;
  String? pin;
  int? status;
  int? rolesId;
  String? roles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUser: json["id_user"],
        nama: json["nama"],
        email: json["email"],
        tglLahir: json["tgl_lahir"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        foto: json["foto"],
        ktp: json["ktp"],
        pin: json["pin"],
        status: json["status"],
        rolesId: json["roles_id"],
        roles: json["roles"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "email": email,
        "tgl_lahir": tglLahir,
        "alamat": alamat,
        "telepon": telepon,
        "foto": foto,
        "ktp": ktp,
        "pin": pin,
        "status": status,
        "roles_id": rolesId,
        "roles": roles,
      };
}
