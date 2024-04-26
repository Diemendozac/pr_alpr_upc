
import 'package:flutter/material.dart';

import '../pages/user_guide_page/user_guide_page.dart';

class UserGuideConstants {

  final List<UserGuide> userManual = [
      UserGuide(
        title: 'Fast, Fluid and Secure',
        description:
        'Enjoy the best of the world in the palm of your hands.',
        image: 'assets/img/guide/image0.png',
        bgColor: Colors.indigo,
      ),
     UserGuide(
        title: 'Connect with your friends.',
        description: 'Connect with your friends anytime anywhere.',
        image: 'assets/img/guide/image1.png',
        bgColor: const Color(0xff1eb090),
      ),
      UserGuide(
        title: 'Bookmark your favourites',
        description:
        'Bookmark your favourite quotes to read at a leisure time.',
        image: 'assets/img/guide/image2.png',
        bgColor: const Color(0xfffeae4f),
      ),
      UserGuide(
        title: 'Follow creators',
        description: 'Follow your favourite creators to stay in the loop.',
        image: 'assets/img/guide/image3.png',
        bgColor: Colors.purple,
      ),
    ];


}