import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/confidence_user.dart';

class UserProvider extends ChangeNotifier {
  final UserService userService = UserService();
  String? email;
  String? name;
  List<Vehicle>? vehicles;
  List<ConfidenceUser>? confidenceUsers;
  String? urlPhoto;
  String? token;
  DateTime? tokenExpirationDate;

  Future<void> findLoggedInUser() async {
    // Realiza la consulta a la API
    var response = await userService.findAllUserData();
    if (response.statusCode == 200) {

      Map<String, dynamic> mapData = jsonDecode(response.body);
      email = mapData["email"]!;
      name = mapData["name"]!;
      vehicles = mapData["associatedVehicles"]!
          .map<Vehicle>((map) => Vehicle.fromJson(map))
          .toList();
      confidenceUsers = mapData["confidenceCircle"]!
          .map<Vehicle>((map) => ConfidenceUser.fromJson(map))
          .toList();
      confidenceUsers = mapData["confidenceCircle"] as List<ConfidenceUser>;
      urlPhoto = "";

      tokenExpirationDate = DateTime.now().add(const Duration(minutes: 30));
    }

    notifyListeners();
  }

  Future<void> save() async {
    // Almacena los datos en el almacenamiento
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email!);
    prefs.setString("name", name!);
    prefs.setStringList("vehicles", vehicles!.map((v) => v.plate).toList());
    prefs.setStringList("confidenceUsers", confidenceUsers!.map((c) => c.email).toList());
    //TODO: Ensure URL not NULL
    prefs.setString("urlPhoto", urlPhoto!);
  }

  bool isTokenValid() {
    return DateTime.now().isBefore(tokenExpirationDate!);
  }

}

