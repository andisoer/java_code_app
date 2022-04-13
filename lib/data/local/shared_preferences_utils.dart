import 'package:java_code_app/data/model/auth_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  late SharedPreferences preferences;

  SharedPreferencesUtils();

  init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static const preferencesName = 'localPreferences';
  static const tagIdUser = 'idUser';
  static const tagEmail = 'email';
  static const tagNama = 'nama';
  static const tagRolesId = 'rolesId';
  static const tagRolse = 'roles';
  static const tagAccess = 'access';
  static const tagIsLoggedIn = 'isLoggedIn';
  static const tagToken = 'token';
  static const tagPin = 'pin';

  setPreferences(User user, String token) async {
    await preferences.setInt(tagIdUser, user.idUser!);
    await preferences.setString(tagEmail, user.email!);
    await preferences.setString(tagNama, user.nama!);
    await preferences.setInt(tagRolesId, user.mRolesId!);
    await preferences.setString(tagRolse, user.roles!);
    await preferences.setBool(tagIsLoggedIn, true);
    await preferences.setString(tagToken, token);
    await preferences.setString(tagPin, user.pin!);
  }

  User getUserPreferences() {
    final int? idUser = preferences.getInt(tagIdUser);
    final String? nama = preferences.getString(tagNama);
    final String? email = preferences.getString(tagEmail);
    final int? rolesId = preferences.getInt(tagRolesId);
    final String? roles = preferences.getString(tagRolse);
    final String? pin = preferences.getString(tagPin);

    User user = User(
      idUser: idUser!,
      email: email!,
      nama: nama!,
      pin: pin,
      foto: "",
      mRolesId: rolesId!,
      isGoogle: 0,
      isCustomer: 0,
      roles: roles!,
      akses: null,
    );

    return user;
  }

  bool isLoggedIn() {
    return preferences.getBool(tagIsLoggedIn) ?? false;
  }

  String getToken() {
    return preferences.getString(tagToken)!;
  }

  bool clearPreferences() {
    preferences.clear();
    return true;
  }
}
