import 'package:flutter/cupertino.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/confidence_user.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final UserService userService = UserService();
  late String email;
  late String name;
  late List<Vehicle> vehicles;
  late List<ConfidenceUser> confidenceUsers;
  late String urlPhoto;
  late String token;
  DateTime? tokenExpirationDate;

  UserProvider() {
    email = "";
    name = "";
    vehicles = [];
    confidenceUsers = [];
    urlPhoto = "";
    token = "";
    tokenExpirationDate = null;
  }

  Future<void> getUsers() async {
    // Realiza la consulta a la API
    User response = await userService.getUser();

    // Asigna los resultados a las propiedades de la clase
    email = response.email;
    name = response.name;
    vehicles = response.vehicles;
    confidenceUsers = response.confidenceUsers;
    urlPhoto = response.urlPhoto;

    // Actualiza la fecha de expiración del token
    tokenExpirationDate = DateTime.now().add(const Duration(minutes: 30));

    // Notifica a los escuchantes de que los datos han cambiado
    notifyListeners();
  }

  Future<void> save() async {
    // Almacena los datos en el almacenamiento
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("name", name);
    prefs.setStringList("vehicles", vehicles.map((v) => v.placa).toList());
    prefs.setStringList("confidenceUsers", confidenceUsers.map((c) => c.email).toList());
    prefs.setString("urlPhoto", urlPhoto);
  }

  bool isTokenValid() {
    return DateTime.now().isBefore(tokenExpirationDate!);
  }
}

