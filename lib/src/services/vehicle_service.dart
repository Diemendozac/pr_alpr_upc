import 'package:http/http.dart' as http;
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'dart:convert';


class VehicleService {
  static String baseUrl = "https://localhost:8080";

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
}
