
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/services/vehicle_service.dart';

class VehicleProvider extends ChangeNotifier {
  final VehicleService vehicleService = VehicleService();
  List<Vehicle> vehicles = [];

  VehicleProvider() {
    this.vehicles = [];
  }

  Future<void> getVehicles() async {
    // Realiza la consulta a la API
    List<Vehicle> response = await vehicleService.getAllAssociatedVehicles();

    // Asigna los resultados a la propiedad de la clase
    this.vehicles = response;

    // Notifica a los escuchantes de que los datos han cambiado
    notifyListeners();
  }
}