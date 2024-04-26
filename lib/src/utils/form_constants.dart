
import 'package:flutter/material.dart';

class FormConstants {

  List<String> brandOptions = [
    'Suzuki',
    'Yamaha',
    'KTM',
    'Bajaj',
    'Hero',
    'Kawasaki'
  ];

  List<String> modelOptions = [
    for (var i = 2024; i > 1990; i -= 1) i.toString()
  ];
  RegExp plateRegex = RegExp('[a-z]{3}([0-9]){2}([a-z0-9]{1})');
  RegExp emailRegex = RegExp('^[a-z0-9.-]+@unicesar.edu.co');

  String? validatePlate(String? plate) {

    plate = plate!.toLowerCase();

    if ( plate.isEmpty) {
      return 'Campo obligatorio';
    }

    if(!plateRegex.hasMatch(plate)) {
      return 'Ingrese un dato válido';
    }
    return null;
  }

  String? validateEmail(String? email) {

    email = email!.toLowerCase();

    if ( email.isEmpty) {
      return 'Campo obligatorio';
    }

    if(!emailRegex.hasMatch(email)) {
      return 'Ingrese un dato válido';
    }
    return null;
  }

  String? validateSelectedValue(String? value) {

    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    return null;
  }

  InputDecoration buildInputDecoration(BuildContext context, String label) {
    Color primaryColor = Theme
        .of(context)
        .colorScheme
        .primary;
    Color errorColor = Theme
        .of(context)
        .colorScheme
        .error;
    BorderRadius inputBorders = const BorderRadius.all(Radius.circular(10));
    TextStyle errorStyle = Theme
        .of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: errorColor, fontWeight: FontWeight.w100, fontSize: 12);

    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: inputBorders),
      focusedBorder: OutlineInputBorder(
        borderRadius: inputBorders,
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      errorStyle: errorStyle,
      errorBorder: OutlineInputBorder(
          borderRadius: inputBorders,
          borderSide: BorderSide(color: errorColor)),
    );
  }
}