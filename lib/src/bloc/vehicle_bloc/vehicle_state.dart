

import '../../models/vehicle.dart';

abstract class VehicleState {}

class VehicleInitial extends VehicleState {}

class VehicleRequestLoading extends VehicleState {}

class ParkedVehiclesRequestLoading extends VehicleState {}



class SuccessfulVehicleRequest extends VehicleState {
  final List<Vehicle> vehicles;

  SuccessfulVehicleRequest(this.vehicles);
}

class VehicleRequestFailed extends VehicleState {
  final String error;
  VehicleRequestFailed(this.error);
}

