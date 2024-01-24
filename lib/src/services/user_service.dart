import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserService {
  //http://ec2-18-231-181-27.sa-east-1.compute.amazonaws.com:8080
  static String baseUrl = 'http://ec2-18-231-181-27.sa-east-1.compute.amazonaws.com:8080';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

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
    return response.statusCode == 200 ? true : false;

  }

  Future<dynamic> loginUser(String email, String password) async {

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
    return response;
  }

  Future<dynamic> findAllUserData() async {
    String? token = await _storage.read(key: 'token');
    if(token == null) return null;
    var response = await http.get(
      Uri.parse('$baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return response;
  }
}
