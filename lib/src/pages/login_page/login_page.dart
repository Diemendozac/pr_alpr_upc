import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/auth_bloc/auth_state.dart';
import 'package:pr_alpr_upc/src/pages/reverse_background_page/reverse_background_page.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';

import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../bloc/user_bloc/user_event.dart';
import '../../bloc/user_bloc/user_state.dart';

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
            Text('Bienvenido a\r\nCampusGate',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left)
          ],
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {

    return Center(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                context.read<UserBloc>().add(LoadUserData());
              } else if (state is Unauthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Session expired. Please log in again.')),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoaded) {
                Navigator.pushReplacementNamed(context, 'home');
              } else if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              TemplateButtons.createPrimaryButton('Registrarse', () async {
                context.read<AuthBloc>().add(SignUpRequested());
              }, context, 0.9),
              const SizedBox(
                height: 10,
              ),
              TemplateButtons.createSecundaryButton('Ingresar', () async {
                context.read<AuthBloc>().add(LoginRequested());
              }, context, 0.9),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )
    );
  }

}
