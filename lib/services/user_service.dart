import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Regresp.dart';

class UserService {
  final SharedPreferences _prefs;

  static const String _keyAccessToken = "access_token";
  static const String _keyRefreshToken = "refresh_token";
  static const String _keyCustomer = "customer_data";

  UserService(this._prefs);

  Future<void> saveSession(String accessToken, String refreshToken, Customer customer) async {
    await _prefs.setString(_keyAccessToken, accessToken);
    await _prefs.setString(_keyRefreshToken, refreshToken);
    await _prefs.setString(_keyCustomer, json.encode(customer.toJson()));
  }

  Future<void> updateTokens(String accessToken, String refreshToken) async {
    await _prefs.setString(_keyAccessToken, accessToken);
    await _prefs.setString(_keyRefreshToken, refreshToken);
  }

  String? get accessToken => _prefs.getString(_keyAccessToken);
  String? get refreshToken => _prefs.getString(_keyRefreshToken);

  Customer? get customer {
    String? data = _prefs.getString(_keyCustomer);
    if (data == null) return null;
    return Customer.fromJson(json.decode(data));
  }

  bool get isLoggedIn => accessToken != null;

  Future<void> clearSession() async {
    await _prefs.remove(_keyAccessToken);
    await _prefs.remove(_keyRefreshToken);
    await _prefs.remove(_keyCustomer);
  }
}
