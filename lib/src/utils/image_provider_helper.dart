
import 'package:flutter/material.dart';


class ImageProviderHelper {
  static ImageProvider getImageProvider(String? userUrlPhoto) {

    if (userUrlPhoto == null || !Uri.parse(userUrlPhoto).isAbsolute ) {
      // Si el photoUrl es nulo, devuelve una imagen Asset
      return const AssetImage('assets/img/default-user.png');
    } else {
      // Si el photoUrl no es nulo, devuelve una imagen de la red
      return NetworkImage(userUrlPhoto);
    }
  }
}