import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/pages/first_page/first_page.dart';
import 'package:pr_alpr_upc/src/pages/login_page/login_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: const [
        FirstPage(),
        LoginPage()
      ],
    );
  }
}
