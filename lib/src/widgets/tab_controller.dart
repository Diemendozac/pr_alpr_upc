import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';
import 'package:tab_container/tab_container.dart';

class UserTabContainer extends StatelessWidget {
  const UserTabContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
                buildListViewConfidenceUser(context),
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
              () {}, context, 0.75)
        ],
      ),
    );
  }

  ListView buildListViewConfidenceUser(BuildContext context) {
    return ListView(
      children: [
        _buildConfidenceUser(
            'Diego Armando Mendoza', 'Diemendozac@gmail.com', context),
        _buildConfidenceUser('Juan', 'juandamec@gmail.com', context)
      ],
    );
  }

  ListTile _buildConfidenceUser(
      String name, String email, BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(email),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: const CircleAvatar(
          child: Image(
            image: AssetImage('assets/img/brands/emily.png'),
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
}
