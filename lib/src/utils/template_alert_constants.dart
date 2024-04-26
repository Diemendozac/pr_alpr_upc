import 'package:flutter/material.dart';

class TemplateAlerts {

  TemplateAlerts._();

  static TemplateAlerts instance = TemplateAlerts._();

  static const errorColor = Color.fromRGBO(244, 67, 54, 1);
  static const warningColor = Colors.amber;
  static const successColor = Color.fromRGBO(86, 125, 244, 1);

  static const Map notAllowedAcountError = {
    'color' : errorColor,
    'icon' : Icons.close,
    'title': 'Error',
    'message': 'Sólo se permiten cuentas institucionales'
  };


  static final Map confidentUserWarning = {
    'color' : warningColor,
    'icon' : Icons.warning,
    'title': 'Precaución',
    'message': 'Los usuarios de confianza pueden salir con tu vehículo'
  };

  static final Map addConfidentUserMessages = {
    200 : 'Solicitud realizada con éxito',
    401 : 'El usuario remitente no se encuentra registrado en la base de datos',
    404 : 'El usuario ingresado no se encuentra registrado en la base de datos',
  };

  static final Map registerMessages = {
    400 : 'El usuario ya se encuentra registrado',
    401 : 'El usuario remitente no se encuentra registrado en la base de datos',
    404 : 'El usuario ingresado no se encuentra registrado en la base de datos',
    406 : 'Sólo se permiten cuentas institucionales',
  };

  static final Map loginMessages = {
    401 : 'Sólo se permiten cuentas institucionales',
    404 : 'El usuario ingresado no se encuentra registrado en la base de datos',
    406 : 'Sólo se permiten cuentas institucionales',
    500 : 'Tuvimos problemas para procesar tu solicitud. Intenta nuevamente',
    501 : 'Tu dispositivo no pudo comunicarse con el servidor. Intenta nuevamente',
  };

  static Map<String, dynamic> buildTemplateArguments(int? statusCode, Map<dynamic, dynamic> messages) {

    late Color color;

    if( statusCode != null) {
      if (statusCode < 300) {
        color = successColor;
      } else {
        color = errorColor;
      }
    } else {
      color = warningColor;
    }

    return {
      'color' : color,
      'icon' : Icons.close,
      'title': 'Error',
      'message': messages[statusCode]
    };

  }

  static void generateAlerts(BuildContext context, dynamic response, Map messages) {
    dynamic arguments = TemplateAlerts.buildTemplateArguments(
      response.statusCode,
      messages,
    );
    Navigator.of(context).pushNamed('alert', arguments: arguments);
  }


}