
import 'package:flutter/material.dart';

import '../models/confidence_user.dart';
import '../services/confidence_user_service.dart';

class ConfidenceUserProvider extends ChangeNotifier {
  final ConfidenceUserService _confidenceUserService = ConfidenceUserService();
  List<ConfidenceUser> confidenceCircle = [];

  ConfidenceUserProvider() {
    confidenceCircle = [];
  }

  Future<void> getVehicles() async {
    // Realiza la consulta a la API
    List<ConfidenceUser> response = await _confidenceUserService.getConfidenceCircle();

    // Asigna los resultados a la propiedad de la clase
    confidenceCircle = response;

    // Notifica a los escuchantes de que los datos han cambiado
    notifyListeners();
  }
}