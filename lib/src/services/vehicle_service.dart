import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'dart:convert';

import '../config/config.dart';

class VehicleService {
  final String baseUrl = Config.serverBaseUrl;
  final dynamic userProvider = null;

  Future<List<dynamic>> saveVehicle(
      String token, Vehicle vehicle) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/vehicle/save'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: json.encode(<String, Object?>{
              'plate': vehicle.plate,
              'brand': vehicle.brand,
              'line': vehicle.line,
              'model': vehicle.model,
              'color': vehicle.color,
            }),
          )
          .timeout(const Duration(seconds: 10));

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
    }
  }

  Future<List<dynamic>> updateVehicle(
      String token, Vehicle vehicle) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/vehicle/update'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: json.encode(<String, Object?>{
              'plate': vehicle.plate,
              'brand': vehicle.brand,
              'line': vehicle.line,
              'model': vehicle.model,
              'color': vehicle.color,
            }),
          )
          .timeout(const Duration(seconds: 10));

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
    }
  }

  Future<List<dynamic>> deleteVehicle(
      String token, String plate) async {
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/vehicle/delete?vehiclePlate=$plate'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
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
    }
  }


}
