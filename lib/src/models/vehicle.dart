class Vehicles {

  List<Vehicle> items = [];

  Vehicles();

  Vehicles.fromJsonList( List<dynamic> jsonList  ) {

    for ( var item in jsonList  ) {
      final vehicle = Vehicle.fromJsonMap(item);
      items.add( vehicle );
    }

  }

}

class Vehicle {
  String? licensePlate;
  String? brand;
  String? engine;
  String? color;

  Vehicle({
    required this.licensePlate,
    required this.brand,
    required this.engine,
    required this.color,
  });

  Vehicle.fromJsonMap( Map<String, dynamic> json ) {

    licensePlate    = json['license_plate'];
    brand           = json['brand'];
    engine          = json['engine'];
    color           = json['color'];

  }

}