import 'package:flutter/material.dart';

class TemplateButtons {

  TemplateButtons._();

  static TemplateButtons instance = TemplateButtons._();

  Widget createPrimaryButton(String text, Function onPressed, BuildContext context, double width) {

    double totalWidth = MediaQuery.of(context).size.width * width;

    return ElevatedButton(
        onPressed: () {onPressed();},
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: Size(totalWidth , 55)
        ),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary
        ))
    );
  }

  Widget createSecundaryButton(String text, Function onPressed, BuildContext context, double width) {

    double totalWidth = MediaQuery.of(context).size.width * width;

    return ElevatedButton(
        onPressed: () {onPressed();},
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: Size(totalWidth , 55)
        ),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary
        ))
    );

  }

  Widget createTertiaryButton(String text, Function onPressed, BuildContext context, double width) {

    double totalWidth = MediaQuery.of(context).size.width * width;

    return ElevatedButton(
        onPressed: () {onPressed();},
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onError,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: Size(totalWidth , 55)
        ),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary
        ))
    );

  }



}