

import 'package:pr_alpr_upc/src/models/vehicle.dart';

class VehicleProvider {

  final List<Map<String, String>> _userVehicles = [
    {
      'licensePlate' : 'WCZ-32A',
      'brand' : 'Suzuki',
      'engine' : '200cc',
      'color' : 'black'
    },
    {
      'licensePlate' : 'ASD-56A',
      'brand' : 'Honda',
      'engine' : '200cc',
      'color' : 'red'
    },
    {
      'licensePlate' : 'QWE-431',
      'brand' : 'Pulsar',
      'engine' : '200cc',
      'color' : 'green'
    },
  ];

  List<Vehicle> get userVehicles => Vehicles.fromJsonList(_userVehicles).items;
}