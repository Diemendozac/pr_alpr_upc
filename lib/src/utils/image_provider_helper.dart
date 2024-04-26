
import 'package:flutter/material.dart';

import '../providers/user_provider.dart';


class ImageProviderHelper {
  static ImageProvider getImageProvider(UserProvider userProvider) {

    String? url = userProvider.getUrlPhoto();
    if (userProvider.getUrlPhoto() == null || !Uri.parse(url!).isAbsolute ) {
      // Si el photoUrl es nulo, devuelve una imagen Asset
      return const AssetImage('assets/img/default-user.png');
    } else {
      // Si el photoUrl no es nulo, devuelve una imagen de la red
      return NetworkImage(userProvider.getUrlPhoto()!);
    }
  }
}