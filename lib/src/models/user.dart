
import 'package:pr_alpr_upc/src/models/vehicle.dart';

import 'confidence_user.dart';

class User {
  String email;
  String name;
  List<Vehicle> vehicles;
  List<ConfidenceUser> confidenceUsers;
  String urlPhoto;

  User({
    required this.email,
    required this.name,
    this.vehicles = const [],
    this.confidenceUsers = const [],
    this.urlPhoto = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      name: json["name"],
      vehicles: List<Vehicle>.from(json["vehicles"].map((c) => Vehicle.fromJson(c))),
      confidenceUsers:
      List<ConfidenceUser>.from(json["confidenceUsers"].map((c) => ConfidenceUser.fromJson(c))),
      urlPhoto: json["urlPhoto"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "vehicles": vehicles.map((v) => v.toJson()).toList(),
      "confidenceUsers": confidenceUsers.map((c) => c.toJson()).toList(),
      "urlPhoto": urlPhoto,
    };
  }
}
