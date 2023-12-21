class Vehicle {
  String placa;
  String marca;
  String linea;
  String color;
  bool isOwner;

  Vehicle({
    required this.placa,
    required this.marca,
    required this.linea,
    required this.color,
    required this.isOwner,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      placa: json["placa"],
      marca: json["marca"],
      linea: json["linea"],
      color: json["color"],
      isOwner: json["isOwner"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "placa": placa,
      "marca": marca,
      "linea": linea,
      "color": color,
      "isOwner": isOwner,
    };
  }
}
