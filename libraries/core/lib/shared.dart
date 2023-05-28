import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  // Сохранение токена в SharedPreferences
  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt_token', token.replaceAll(RegExp('"'), ''));
  }

  // Получение токена из SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  void deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
  }
}
