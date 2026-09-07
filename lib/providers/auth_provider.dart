import 'package:flutter/material.dart';
import '../services/apiservice.dart';

class AuthProvider extends ChangeNotifier {
  final Apiservice _apiService;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._apiService);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> requestOtp(String phone) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.requestOtp(phone);
      _isLoading = false;
      if (response != null) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Failed to request OTP";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String phone, String code) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // For now, passing empty name and email as they might be required by the API but not yet collected
      final response = await _apiService.verifyOtp(phone, code, "nicy", "nicy@gmail.com");
      _isLoading = false;
      if (response != null) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Invalid OTP";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
