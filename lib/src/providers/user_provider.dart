import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/confidence_user.dart';

class UserProvider extends ChangeNotifier {
  final UserService userService = UserService();
  String? _email;
  String? _name;
  List<Vehicle>? _vehicles;
  List<ConfidenceUser>? _confidenceUsers;
  String? _urlPhoto;
  String? _token;
  DateTime? _tokenExpirationDate;

  Future<void> findLoggedInUser() async {
    // Realiza la consulta a la API
    var response = await userService.findAllUserData();
    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);
      _email = mapData["email"]!;
      _name = mapData["name"]!;
      _vehicles = mapData["associatedVehicles"]
              .map<Vehicle>((map) => Vehicle.fromJson(map))
              .toList() ??
          [];
      _confidenceUsers = mapData['confidenceUsers']
          .map<ConfidenceUser>(
              (confidenceUser) => ConfidenceUser.fromJson(confidenceUser))
          .toList() ?? [];
      _urlPhoto = "";

      _tokenExpirationDate = DateTime.now().add(const Duration(minutes: 30));
    }

    notifyListeners();
  }

  Future<void> save() async {
    // Almacena los datos en el almacenamiento
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _email!);
    prefs.setString("name", _name!);
    prefs.setStringList("vehicles", _vehicles!.map((v) => v.plate).toList());
    prefs.setStringList(
        "confidenceUsers", _confidenceUsers!.map((c) => c.email).toList());
    //TODO: Ensure URL not NULL
    prefs.setString("urlPhoto", _urlPhoto!);
  }

  bool isTokenValid() {
    return DateTime.now().isBefore(_tokenExpirationDate!);
  }

  set tokenExpirationDate(DateTime value) {
    _tokenExpirationDate = value;
  }

  set token(String value) {
    _token = value;
  }

  set urlPhoto(String value) {
    _urlPhoto = value;
  }

  set confidenceUsers(List<ConfidenceUser> value) {
    _confidenceUsers = value;
  }

  set vehicles(List<Vehicle> value) {
    _vehicles = value;
  }

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  String? getName () { return _name;}

  String? getEmail () { return _email;}

  List<Vehicle>? getVehicles() {return _vehicles;}

  List<ConfidenceUser>? getConfidenceUsers(){ return _confidenceUsers;}

  String? getUrlPhoto() { return _urlPhoto; }

  String ? getToken () { return _token; }

  DateTime? getTokenExpirationDate() { return _tokenExpirationDate; }
}
