import 'package:flutter/material.dart';

class TemplateAlerts {

  TemplateAlerts._();

  static TemplateAlerts instance = TemplateAlerts._();

  static const errorColor = Color.fromRGBO(244, 67, 54, 1);
  static const warningColor = Colors.amber;
  static const successColor = Color.fromRGBO(86, 125, 244, 1);

  final Map notAllowedAcountError = {
    'color' : errorColor,
    'icon' : Icons.close,
    'title': 'Error',
    'message': 'Sólo se permiten cuentas institucionales'
  };

  final Map confidentUserWarning = {
    'color' : warningColor,
    'icon' : Icons.warning,
    'title': 'Precaución',
    'message': 'Los usuarios de confianza pueden salir con tu vehículo'
  };

  final Map addConfidentUserMessages = {
    200 : 'Solicitud realizada con éxito',
    401 : 'El usuario remitente no se encuentra registrado en la base de datos',
    404 : 'El usuario ingresado no se encuentra registrado en la base de datos',
  };

  Map<String, dynamic> buildTemplateArguments(int statusCode, Map<dynamic, dynamic> messages) {
    return {
      'color' : errorColor,
      'icon' : Icons.close,
      'title': 'Error',
      'message': messages[statusCode]
    };

  }

  void generateTemplateAlert(int statusCode, Map<String, dynamic> arguments, BuildContext context) {

    if (context.mounted) {
      if (statusCode >= 400) {
        Navigator.pushNamed(context, 'alert',
            arguments: arguments
        );
        return;
      }
      Navigator.pop(context, true);
    }

  }


}