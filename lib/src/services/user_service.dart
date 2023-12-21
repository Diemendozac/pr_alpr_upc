import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

class UserService {
  static String baseUrl = "http://ec2-18-231-181-27.sa-east-1.compute.amazonaws.com:8080";

  Future<User>getUser() async {
    // Realiza la consulta a la API

    var response = await http.get(Uri.parse("$baseUrl/users"));

    // Comprueba el estado de la respuesta
    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios");
    }

    // Decodifica los datos de la respuesta
    User user = User.fromJson(jsonDecode(response.body).map((c) => User.fromJson(c)));

    return user;
  }

  Future<bool> saveUser(String email, String password, String name, String? photo ) async {

    String photoUrl = photo ?? 'null';
    var response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(
          <String, Object?>{
        'email': email,
        'password': password,
        'name': name,
        'photoUrl': photoUrl,
        'phoneNumber': null,
        'confidenceCircle': []
      }),
    );
    print(await response.body);
    return response.statusCode == 200 ? true : false;

  }

  Future<bool> loginUser(String email, String password) async {

    var response = await http.post(
      Uri.parse('$baseUrl/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(
          <String, Object?>{
            'email': email,
            'password': password,
          }),
    );
    print(await response.body);
    return response.statusCode == 200 ? true : false;

  }
}
