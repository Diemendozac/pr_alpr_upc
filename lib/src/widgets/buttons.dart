import 'package:flutter/material.dart';

class TemplateButtons {

  Widget createPrimaryButton(String text, Function onPressed, BuildContext context, double width) {

    double totalWidth = MediaQuery.of(context).size.width * width;

    return ElevatedButton(
        onPressed: () {onPressed();},
        child: Text(text),
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: Size(totalWidth , 55)
        )
    );

  }

  Widget createSecundaryButton(String text, Function onPressed, BuildContext context, double width) {

    double totalWidth = MediaQuery.of(context).size.width * width;

    return ElevatedButton(
        onPressed: () {onPressed();},
        child: Text(text),
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: Size(totalWidth , 55)
        )
    );

  }

}