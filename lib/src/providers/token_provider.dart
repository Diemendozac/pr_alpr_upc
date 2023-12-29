
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';

class TokenProvider extends ChangeNotifier {
  final UserService userService = UserService();
  String? token;

  Future<String?> saveToken(String email, String password) async {
    final response = await userService.loginUser(email, password);

    if (response.statusCode == 200) {

      Map<String, dynamic> tokenMap = jsonDecode(response.body);
      return tokenMap['token']!;

    }
    notifyListeners();
    return null;

  }
}