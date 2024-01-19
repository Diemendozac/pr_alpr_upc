import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'dart:convert';


class VehicleService {
  static String baseUrl = "http://ec2-18-231-181-27.sa-east-1.compute.amazonaws.com:8080";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<Vehicle>> getAllAssociatedVehicles() async {

    var response = await http.get(Uri.parse("$baseUrl/vehicle"));

    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios");
    }

    // Decodifica los datos de la respuesta
    List<Vehicle> vehicles = List<Vehicle>.from(
        jsonDecode(response.body).map((c) => Vehicle.fromJson(c)));

    return vehicles;
  }

  Future<bool?> saveVehicle(Vehicle vehicle) async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.post(
      Uri.parse('$baseUrl/vehicle/save'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(
          <String, Object?>{
            'plate': vehicle.plate,
            'brand': vehicle.brand,
            'line': vehicle.line,
            'model': vehicle.model,
            'color': vehicle.color,
          }),
    );
    print(jsonDecode(response.body));
    return response.statusCode == 200 ? true : false;

  }

  Future<bool?> updateVehicle(Vehicle vehicle) async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.put(
      Uri.parse('$baseUrl/vehicle/update'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(
          <String, Object?>{
            'plate': vehicle.plate,
            'brand': vehicle.brand,
            'line': vehicle.line,
            'model': vehicle.model,
            'color': vehicle.color,
          }),
    );
    return response.statusCode == 200 ? true : false;
  }

  Future<bool?> deleteVehicle(String plate) async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;
    String deleteEndPoint = '$baseUrl/vehicle/delete?vehiclePlate=$plate';
    var response = await http.delete(
      Uri.parse(deleteEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return response.statusCode == 200 ? true : false;
  }

}
