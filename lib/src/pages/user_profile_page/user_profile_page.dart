import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/utils/form_constants.dart';
import 'package:pr_alpr_upc/src/utils/image_provider_helper.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FormConstants formConstants = FormConstants();

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil', style: Theme.of(context).textTheme.titleMedium),
        surfaceTintColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.background,

    ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: ImageProviderHelper.getImageProvider('')),
                    )
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: formConstants.buildInputDecoration(context, 'Nombre'),
                        initialValue: '',
                        enabled: false,
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                          decoration: formConstants.buildInputDecoration(context, 'Email'),
                        enabled: false,
                        initialValue: '',
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                          decoration: formConstants.buildInputDecoration(context, 'Teléfono'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 25),
                      TemplateButtons.createPrimaryButton('Editar', (){}, context, 1),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}