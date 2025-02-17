import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import 'auth_service.dart';

class UserService {
  final String baseUrl = Config.serverBaseUrl;
  final AuthService authService = AuthService();

  Future<Map<String, dynamic>> fetchData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/login'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error al obtener datos del usuario: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> updateData(String token, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/data'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error al actualizar datos del usuario: ${response.body}");
    }
  }
}

