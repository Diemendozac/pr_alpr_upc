import 'package:flutter/material.dart';

import '../../../services/confidence_user_service.dart';
import '../../../utils/form_constants.dart';
import '../../../utils/template_alert_constants.dart';

class AddUserFormDialog extends StatefulWidget {
  final ConfidenceUserService confidenceUserService;

  const AddUserFormDialog({super.key, required this.confidenceUserService});

  @override
  AddUserFormDialogState createState() => AddUserFormDialogState();
}

class AddUserFormDialogState extends State<AddUserFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formConstants = FormConstants();

    return AlertDialog(
      scrollable: true,
      title: const Text('Añadir usuario'),
      titlePadding: const EdgeInsets.only(left: 30, top: 20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: emailEditingController,
                decoration: formConstants.buildInputDecoration(
                  context,
                  'Ingresa su correo:',
                ),
                validator: (value) {
                  return formConstants.validateEmail(value);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final httpResponse = await widget.confidenceUserService.addConfidenceUser(emailEditingController.text);
                    if (context.mounted && httpResponse.statusCode >= 300) {
                      TemplateAlerts.generateAlerts(context, httpResponse, TemplateAlerts.addConfidentUserMessages);
                    }
                  }
                },
                child: const Text('Añadir Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
