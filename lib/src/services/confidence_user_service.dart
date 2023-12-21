import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/confidence_user.dart';

class ConfidenceUserService {
  static String baseUrl = "https://localhost:8080";

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
}
