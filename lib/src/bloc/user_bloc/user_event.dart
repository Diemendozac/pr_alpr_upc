import 'package:equatable/equatable.dart';

import '../../models/vehicle.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserData extends UserEvent {}

class UpdateUserData extends UserEvent {
  final Map<String, dynamic> updatedData;

  const UpdateUserData(this.updatedData);

  @override
  List<Object> get props => [updatedData];
}

class UserSignOutRequested extends UserEvent {}

class UpdateUserVehicles extends UserEvent {
  final List<Vehicle> vehiclesToUpdate;

  const UpdateUserVehicles(this.vehiclesToUpdate);
}


