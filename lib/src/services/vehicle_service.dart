import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'dart:convert';

import 'package:pr_alpr_upc/src/providers/user_provider.dart';

import 'local_storage.dart';


class VehicleService {

  final String baseUrl = LocalStorage.prefs.getString('baseUrl')!;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final UserProvider userProvider = UserProvider.instance;

  Future<dynamic> getAllAssociatedVehicles() async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.get(
      Uri.parse('$baseUrl/user/vehicles'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios");
    }

    refreshVehicles(response.body);

    return true;
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
    if (response.statusCode == 200) refreshVehicles(response.body);
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

    if (response.statusCode == 200) refreshVehicles(response.body);
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
    if (response.statusCode == 200) refreshVehicles(response.body);
    return response.statusCode == 200 ? true : false;
  }

  void refreshVehicles(String body) {

    List<dynamic> mapData = jsonDecode(body);

    List<Vehicle> vehicles = [];
    try {
       vehicles = mapData.map<Vehicle>((map) => Vehicle.fromJson(map))
          .toList();
    } catch (e) {
      vehicles = [];
    } finally {
      userProvider.setVehicles(vehicles);
    }

  }

}
