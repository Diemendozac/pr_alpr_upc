class Vehicle {
  String plate;
  String brand;
  String line;
  int model;
  String? color;
  bool isOwner;

  Vehicle({
    required this.plate,
    required this.brand,
    required this.line,
    required this.model,
    required this.color,
    required this.isOwner,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      plate: json["plate"],
      brand: json["brand"],
      line: json["line"],
      model: json["model"],
      color: json["color"],
      isOwner: json["owner"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "plate": plate,
      "brand": brand,
      "line": line,
      "model": model,
      "color": color,
      "isOwner": isOwner,
    };
  }
}
