import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> clearRefreshToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences prefs;

  AuthLocalDatasourceImpl({required this.prefs});

  static const String _tokenKey = "AUTH_TOKEN";
  static const String _refreshTokenKey = "REFRESH_TOKEN";

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

  @override
  Future<void> saveRefreshToken(String token) async {
    await prefs.setString(_refreshTokenKey, token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return prefs.getString(_refreshTokenKey);
  }

  @override
  Future<void> clearRefreshToken() async {
    await prefs.remove(_refreshTokenKey);
  }
}
