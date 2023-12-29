import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/pages/reverse_background_page.dart';
import 'package:pr_alpr_upc/src/services/google_auth_service.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../providers/auth_state.dart';

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
    GoogleAuthService authService = GoogleAuthService.instance;

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Expanded(child: SizedBox()),
        templateButtons.createPrimaryButton('Login', () {
          authService.handleSignUp(context);
        }, context, 0.9),
        const SizedBox(
          height: 10,
        ),
        templateButtons.createSecundaryButton('Sign In', () async {
          bool isAuthenticated = await authService.handleLogIn(context);
          final authState = context.read<AuthState>();
          authState.setLoggedIn(isAuthenticated);
        }, context, 0.9),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }
}
