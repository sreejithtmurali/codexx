import 'package:codex/models/Otpreqresp.dart';
import 'package:codex/models/Regresp.dart';
import 'package:codex/services/user_service.dart';
import 'package:flutter/material.dart';
import '../services/apiservice.dart';

class AuthProvider extends ChangeNotifier {
  final Apiservice _apiService;
  final UserService _userService;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  AuthProvider(this._apiService, this._userService);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  bool get isAuthenticated => _userService.isLoggedIn;
  Customer? get currentUser => _userService.customer;

  Future<Otpreqresp?> requestOtp(String phone) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.requestOtp(phone);
      _isLoading = false;
      if (response != null && response.success == true) {
        _successMessage = response.message;
        notifyListeners();
        return response;
      } else {
        _errorMessage = response?.message ?? "Failed to request OTP";
        notifyListeners();
        return response;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<Regresp?> verifyOtp(String phone, String code) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // For now, passing empty name and email as they might be required by the API but not yet collected
      final response = await _apiService.verifyOtp(phone, code, "nicy", "nicy@gmail.com");
      _isLoading = false;
      if (response != null && response.success == true) {
        notifyListeners();
        return response;
      } else {
        _errorMessage = "Invalid OTP";
        notifyListeners();
        return response;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<void> logout() async {
    await _apiService.logout();
    notifyListeners();
  }
}
