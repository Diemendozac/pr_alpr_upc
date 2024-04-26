
import 'package:flutter/material.dart';

import '../pages/user_guide_page/user_guide_page.dart';

class UserGuideConstants {

  final List<UserGuide> userManual = [
      UserGuide(
        title: 'Seguridad y Practicidad',
        description:
        'Despreocúpate por el ticket de tu vehículo',
        image: 'assets/img/guide/secure_asset.svg',
        bgColor: const Color(0xfffeae4f),
      ),
      UserGuide(
        title: 'Usuarios de Confianza',
        description:
        'Comparte el accesso a tu vehículo con tus amigos',
        image: 'assets/img/guide/friendship_asset.svg',
        bgColor: Colors.indigo,
      ),
     UserGuide(
        title: 'Notificaciones y Registros',
        description: 'Te mantenemos atento y guardamos registro de tus ingresos',
        image: 'assets/img/guide/notification_asset.svg',
        bgColor: const Color(0xff1eb090),
      ),
    ];

}