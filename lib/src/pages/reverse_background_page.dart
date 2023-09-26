import 'package:flutter/material.dart';

import '../theme/image_manager.dart';

class ReverseBackgroundPage extends StatelessWidget {
  ImageManager imageManager = ImageManager.instance;

  final Widget contentWidget;

  ReverseBackgroundPage(this.contentWidget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          imageManager.getBackgroundTopImage(context),
          contentWidget,
        ],
      ),
    );
  }
}
