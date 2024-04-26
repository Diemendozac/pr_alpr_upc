
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';

class TokenProvider extends ChangeNotifier {
  final UserService userService = UserService();
  String? token;

  Future<dynamic> saveToken(String email, String password) async {
    final response = await userService.loginUser(email, password);
    const FlutterSecureStorage storage = FlutterSecureStorage();

    if (response.statusCode == 200) {
      Map<String, dynamic> tokenMap = jsonDecode(response.body);
      await storage.write(key: 'token', value: tokenMap['token']);
      notifyListeners();
      return response;

    }

    return response;

  }
}