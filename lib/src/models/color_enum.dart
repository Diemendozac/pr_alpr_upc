import 'dart:ui';

import 'package:flutter/material.dart';

List<String> colors = [
  "AMARILLO",
  "AZUL",
  "BLANCO",
  "CAFÉ",
  "DORADO",
  "GRIS",
  "NARANJA",
  "NEGRO",
  "PLATEADO",
  "ROJO",
  "VERDE",
];

Color getColor(String color) {
  switch (color) {
    case "AMARILLO":
      return Colors.yellow;
    case "AZUL":
      return Colors.blue;
    case "BLANCO":
      return Colors.white;
    case "CAFÉ":
      return Colors.brown;
    case "DORADO":
      return Colors.amber;
    case "GRIS":
      return Colors.white38;
    case "NARANJA":
      return Colors.orange;
    case "NEGRO":
      return Colors.black;
    case "PLATEADO":
      return Colors.grey;
    case "ROJO":
      return Colors.red;
    case "VERDE":
      return Colors.green;
    default:
      return Colors.transparent;
  }
}
