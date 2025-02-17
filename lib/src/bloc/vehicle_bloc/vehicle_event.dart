// statistics_event.dart

import 'package:pr_alpr_upc/src/models/vehicle.dart';

abstract class VehicleEvent {}

class SaveVehicleRequested extends VehicleEvent {
  final Vehicle vehicle;

  SaveVehicleRequested(this.vehicle);
}
class UpdateVehicleRequested extends VehicleEvent {
  final Vehicle vehicle;

  UpdateVehicleRequested(this.vehicle);
}

class DeleteVehicleRequested extends VehicleEvent {
  final String vehiclePlate;

  DeleteVehicleRequested(this.vehiclePlate);
}

