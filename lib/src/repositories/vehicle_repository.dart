
import '../models/vehicle.dart';
import '../services/auth_service.dart';
import '../services/vehicle_service.dart';

class VehicleRepository {
  final AuthService _authService = AuthService();
  final VehicleService vehicleService;

  VehicleRepository({required this.vehicleService});

  Future<dynamic> saveVehicle(Vehicle vehicle) async {
    final token = await _authService.getToken();
    if (token == null) throw Exception("Token not found");

    final response = await vehicleService.saveVehicle(token, vehicle);
    return response.map((v) => Vehicle.fromJson(v)).toList();
  }

  Future<dynamic> updateVehicle(Vehicle vehicle) async {
    final token = await _authService.getToken();
    if (token == null) throw Exception("Token not found");

    final response = await vehicleService.updateVehicle(token, vehicle);
    return response.map((v) => Vehicle.fromJson(v)).toList();

  }

  Future<dynamic> deleteVehicle(String vehiclesPlateToDelete) async {
    final token = await _authService.getToken();
    if (token == null) throw Exception("Token not found");

    final response = await vehicleService.deleteVehicle(token, vehiclesPlateToDelete);
    return response.map((v) => Vehicle.fromJson(v)).toList();
  }
}
