import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pr_alpr_upc/src/pages/reverse_background_page/reverse_background_page.dart';
import 'package:pr_alpr_upc/src/services/google_auth_service.dart';
import 'package:pr_alpr_upc/src/utils/template_alert_constants.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_state.dart';

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
                  'CampusGate',
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
    const FlutterSecureStorage storage = FlutterSecureStorage();

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Expanded(child: SizedBox()),
        templateButtons.createPrimaryButton('Registrarse', () async {
          dynamic response = await authService.handleSignUp(context);
          if (response.statusCode >= 300) {
            TemplateAlerts.generateAlerts(context, response, TemplateAlerts.registerMessages);
          }
        }, context, 0.9),
        const SizedBox(
          height: 10,
        ),
        templateButtons.createSecundaryButton('Ingresar', () async {
          dynamic response = await authService.handleLogIn(context);
          if (response.statusCode >= 300) {
            TemplateAlerts.generateAlerts(context, response, TemplateAlerts.loginMessages);
          }
          final authState = context.read<AuthState>();
          authState.setLoggedIn(await storage.read(key: 'token') != null);
        }, context, 0.9),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }

}
