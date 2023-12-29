
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/services/google_auth_service.dart';

class AuthState extends ChangeNotifier {

  bool _isLoggedIn = false;
  GoogleAuthService authService = GoogleAuthService.instance;

  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void logOutUser() {
    _isLoggedIn = false;
    authService.handleSignOut();
    notifyListeners();
  }
}
