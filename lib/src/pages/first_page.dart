import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/pages/double_background_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackgroundPage(_createWidget(context));
  }

  Widget _createWidget(BuildContext context) {

    return Center(
      child: Text('Aplicación', style: Theme.of(context).textTheme.titleLarge),
    );

  }
}
