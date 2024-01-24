import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/confidence_user.dart';

class ConfidenceUserService {

  static String baseUrl = "https://localhost:8080";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<ConfidenceUser>>getConfidenceCircle() async {
    // Realiza la consulta a la API

    var response = await http.get(Uri.parse("$baseUrl/confidence-circle"));

    // Comprueba el estado de la respuesta
    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios");
    }

    // Decodifica los datos de la respuesta
    List<ConfidenceUser> confidenceCircle = List<ConfidenceUser>.from(
        jsonDecode(response.body).map((c) => ConfidenceUser.fromJson(c)));

    return confidenceCircle;
  }

  Future<dynamic> addConfidenceUser(String confidenceUserEmail) async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.post(
      Uri.parse('$baseUrl/confidence-circle?email=$confidenceUserEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return response;
  }
}
