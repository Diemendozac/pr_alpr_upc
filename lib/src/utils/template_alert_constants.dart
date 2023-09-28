import 'package:flutter/material.dart';

class TemplateAlerts {

  TemplateAlerts._();

  static TemplateAlerts instance = TemplateAlerts._();

  static const errorColor = Color.fromRGBO(244, 67, 54, 1);
  static const warningColor = Colors.amber;
  static const successColor = Color.fromRGBO(86, 125, 244, 1);

  final Map notAllowedAcount = {
    'color' : errorColor,
    'icon' : Icons.close,
    'title': 'Error',
    'message': 'Sólo se permiten cuentas institucionales'
  };

}