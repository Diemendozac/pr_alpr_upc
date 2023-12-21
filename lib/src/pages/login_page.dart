import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/pages/reverse_background_page.dart';
import 'package:pr_alpr_upc/src/services/auth_service.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReverseBackgroundPage(_createElements(context));
  }

  Widget _createElements(BuildContext context) {
    return Stack(
      children: [_createHeader(context), _createBody(context)],
    );
  }

  Widget _createHeader(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bienvenido a',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left),
                Text(
                  'Aplicación',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    TemplateButtons templateButtons = TemplateButtons.instance;
    AuthService authService = AuthService.instance;

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Expanded(child: SizedBox()),
        templateButtons.createPrimaryButton('Login', () {
          authService.handleSignIn(context);
        }, context, 0.9),
        const SizedBox(
          height: 10,
        ),
        templateButtons.createSecundaryButton('Sign In', () {
          authService.handleLogIn(context);
        }, context, 0.9),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }
}
