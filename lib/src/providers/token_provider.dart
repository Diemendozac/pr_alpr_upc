
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/models/response_model.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';

class TokenProvider extends ChangeNotifier {
  final UserService userService = UserService();
  String? token;

  Future<void> saveToken(String email, String password) async {
    // Realiza la consulta a la API
    var response = await userService.loginUser(email, password);
    ResponseModel responseData = ResponseModel.fromJson(json.decode(response.body));

    if (responseData.status == 200) {

      String tokenString = responseData.data;
      String formattedToken = responseData.data.substring(1, tokenString.length - 1);
      Map<String, String> tokenMap = _parseTokenString(formattedToken);
      String token = tokenMap["token"]!;


    }

    // Asigna los resultados a la propiedad de la clase

    // Notifica a los escuchantes de que los datos han cambiado
    notifyListeners();
  }

  Map<String, String> _parseTokenString(String tokenString) {
    List<String> tokenPairs = tokenString.split(', ');

    Map<String, String> tokenMap = {};

    for (String pair in tokenPairs) {
      List<String> keyValue = pair.split(': ');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        tokenMap[key] = value;
      }
    }

    return tokenMap;
  }
}