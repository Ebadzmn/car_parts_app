import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences prefs;

  AuthLocalDatasourceImpl({required this.prefs});

  static const String _tokenKey = "AUTH_TOKEN";

  @override
  Future<void> clearToken() async {
    await prefs.remove(_tokenKey);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }
}
