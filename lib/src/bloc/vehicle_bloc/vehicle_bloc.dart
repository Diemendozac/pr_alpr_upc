// statistics_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/vehicle_repository.dart';
import '../../services/device_auth_service.dart';
import 'vehicle_event.dart';
import 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository vehicleRepository;
  final DeviceAuthService _deviceAuthService = DeviceAuthService();

  VehicleBloc({required this.vehicleRepository}) : super(VehicleInitial()) {
    on<SaveVehicleRequested>(_onSaveVehicleRequested);
    on<UpdateVehicleRequested>(_onUpdateVehicleRequested);
    on<DeleteVehicleRequested>(_onDeleteVehicleRequested);
  }

  Future<void> _onSaveVehicleRequested(
      SaveVehicleRequested event, Emitter<VehicleState> emit) async {
    emit(VehicleRequestLoading());
    try {
      final response = await vehicleRepository.saveVehicle(event.vehicle);
      emit(SuccessfulVehicleRequest(response));
    } catch (error) {
      emit(VehicleRequestFailed("Failed to load parked vehicles: $error"));
      emit(VehicleInitial());
    }
  }

  Future<void> _onUpdateVehicleRequested(
      UpdateVehicleRequested event, Emitter<VehicleState> emit) async {
    emit(VehicleRequestLoading());
    try {
      final response = await vehicleRepository.updateVehicle(event.vehicle);
      emit(SuccessfulVehicleRequest(response));
    } catch (error) {
      emit(VehicleRequestFailed("Failed to load parked vehicles: $error"));
      emit(VehicleInitial());
    }
  }

  Future<void> _onDeleteVehicleRequested(
      DeleteVehicleRequested event, Emitter<VehicleState> emit) async {
    emit(VehicleRequestLoading());

    // **Autenticación antes de eliminar**
    bool isAuthenticated = await _deviceAuthService.authenticate();
    if (!isAuthenticated) {
      emit(VehicleRequestFailed("Authentication failed. Vehicle deletion denied."));
      return;
    }

    try {
      final response = await vehicleRepository.deleteVehicle(event.vehiclePlate);
      emit(SuccessfulVehicleRequest(response));
    } catch (error) {
      emit(VehicleRequestFailed("Failed to delete vehicle: $error"));
      emit(VehicleInitial());
    }
  }

}
