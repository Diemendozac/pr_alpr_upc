import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _storage = const FlutterSecureStorage();
  final String baseUrl = Config.serverBaseUrl;

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final email = googleUser.email;
      if (!email.endsWith('@unicesar.edu.co')) {
        throw Exception("Dominio no permitido");
      }

      final response = await http.post(
        Uri.parse('$baseUrl/authenticate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': googleUser.id}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Login error: ${response.body}");
      }
    } on SocketException {
      throw Exception("No tienes conexión a internet.");
    } on TimeoutException {
      throw Exception("El servidor no ha podido responder.");
    } catch (e) {
      throw Exception("An error occurred: $e");
    } finally {
      signOut();
    }
  }

  Future<Map<String, dynamic>?> signUpWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final email = googleUser.email;
      if (!email.endsWith('@unicesar.edu.co')) {
        throw Exception("Dominio no permitido");
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {
              'email': email,
              'password': googleUser.id,
              'name': googleUser.displayName,
              'photoUrl': googleUser.photoUrl,
              'phoneNumber': null,
              'confidenceCircle': []
            }
        ),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception("Login error: ${response.body}");
      }
    } on SocketException {
      throw Exception("No tienes conexión a internet.");
    } on TimeoutException {
      throw Exception("El servidor no ha podido responder.");
    } catch (e) {
      throw Exception("An error occurred: $e");
    } finally {
      signOut();
    }
  }

  Future<Map<String, dynamic>> fetchData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error al obtener datos: ${response.body}");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.delete(key: 'auth_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> verifyToken(String token) async {
    final response = {
      'statusCode' : 200
    };

    if (response['statusCode'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}