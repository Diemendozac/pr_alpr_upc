
class VehicleProvider {

  List<Map<String, String>> _userVehicles = [
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

  List<Map<String, String>> get userVehicles => _userVehicles;
}