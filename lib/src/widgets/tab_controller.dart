import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/services/confidence_user_service.dart';
import 'package:pr_alpr_upc/src/utils/form_constants.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'package:tab_container/tab_container.dart';

import '../models/confidence_user.dart';
import '../providers/user_provider.dart';

class UserTabContainer extends StatelessWidget {
  UserTabContainer({super.key});
  final formKey = GlobalKey<FormState>();
  final ConfidenceUserService confidenceUserService = ConfidenceUserService();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    TemplateButtons templateButtons = TemplateButtons.instance;

    TextStyle? titleTheme = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 17,
        fontWeight: FontWeight.bold);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: TabContainer(
          selectedTextStyle: titleTheme,
          unselectedTextStyle: titleTheme,
          radius: 20,
          color: Theme.of(context).colorScheme.surface,
          tabs: const [
            'Usuarios de Confianza',
            'Solicitudes',
          ],
          children: [
            Stack(
              children: [
                buildListViewConfidenceUser(context, userProvider.getConfidenceUsers() ?? []),
                buildBottomAddButton(templateButtons, context)
              ],
            ),
            const Text('Child 2'),
          ],
        ),
      ),
    );
  }

  Padding buildBottomAddButton(
      TemplateButtons templateButtons, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          templateButtons.createTertiaryButton('Agregar usuario de confianza',
              () {showForm(context);}, context, 0.75)
        ],
      ),
    );
  }

  ListView buildListViewConfidenceUser(BuildContext context, List<ConfidenceUser> confidenceUsers) {
    return ListView(
      children: confidenceUsers.map((user) => _buildConfidenceUser(user, context)).toList(),
    );
  }

  ListTile _buildConfidenceUser(
      ConfidenceUser confidenceUser, BuildContext context) {
    return ListTile(
      title: Text(
        confidenceUser.name,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(confidenceUser.email),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: const CircleAvatar(
          child: Image(
            image: AssetImage('assets/img/brands/emily.png'),
            // AssetImage('assets/img/brands/emily.png')
            fit: BoxFit.cover,
          ),
        ),
      ),
      trailing: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<void> showForm(BuildContext context) async {

    final TextEditingController emailEditingController = TextEditingController();
    FormConstants formConstants = FormConstants();

    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: const Text('Añadir usuario'),
          titlePadding: const EdgeInsets.only(left: 30, top: 20),
          content: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12,),
                      TextFormField(
                        controller: emailEditingController,
                          decoration: formConstants.buildInputDecoration(context, 'Ingresa su correo:'),
                          validator: (value) {
                            return formConstants.validatePlate(value);
                          }),
                      const SizedBox(height: 24,),
                      _buildFormButton(context, emailEditingController.text)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

  }

  Widget _buildFormButton(BuildContext context, String requestEmail) {

    ElevatedButton formButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(48))
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          bool? httpResponse = await confidenceUserService.addConfidenceUser(requestEmail);
          print(httpResponse);
        }

      },
      child: Text('Añadir Usuario'),
    );

    return formButton;

  }

}
