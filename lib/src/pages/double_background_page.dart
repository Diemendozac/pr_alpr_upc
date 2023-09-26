import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/theme/image_manager.dart';


class DoubleBackgroundPage extends StatelessWidget {

  ImageManager imageManager = ImageManager.instance;

  final Widget contentWidget;

  DoubleBackgroundPage( this.contentWidget );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          imageManager.getBackgroundTopCicleImage(),
          imageManager.getBackgroundBottomImage(context),
          contentWidget,
        ],
      ),
    );
  }
}
