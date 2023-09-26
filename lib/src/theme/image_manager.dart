import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/theme/theme_manager.dart';

class ImageManager {

  ThemeManager themeManager = ThemeManager.instance;
  ImageManager._();

  static ImageManager instance = ImageManager._();

  String setPath() {
    return themeManager.themeMode == ThemeMode.dark ? 'dark' : 'light';
  }

  Widget getBackgroundTopCicleImage() {
    String path = 'assets/img/${setPath()}/background.png';
    return Container(
      alignment: Alignment.topRight,
        child: Image(image: AssetImage(path)),

    );
  }

  Widget getBackgroundBottomImage(BuildContext context) {
    String path = 'assets/img/${setPath()}/background-1.png';
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.bottomLeft,
      child: Image(
        image: AssetImage(path),
        fit: BoxFit.contain,
        width: widthSize * 0.8,
        height: heightSize * 0.3,
      ),
    );
  }

  Widget getBackgroundTopImage(BuildContext context) {
    String path = 'assets/img/${setPath()}/background-1-reverse.png';
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.topRight,
      child: Image(
        image: AssetImage(path),
        fit: BoxFit.contain,
        width: widthSize * 0.45,
        height: heightSize * 0.3,
      ),
    );
  }

  Widget getBackgroundBottomAlertImage(BuildContext context) {
    String path = 'assets/img/alert/background-alert-bottom.png';
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.bottomLeft,
      child: Image(
        image: AssetImage(path),
        fit: BoxFit.contain,
        width: widthSize * 0.5,
        height: heightSize * 0.3,
      ),
    );
  }

  Widget getBackgroundTopAlertImage(BuildContext context) {
    String path = 'assets/img/alert/background-alert-top.png';
    double heightSize = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.topRight,
      child: Image(
        image: AssetImage(path),
        fit: BoxFit.contain,
        height: heightSize * 0.3,
      ),
    );
  }




}
