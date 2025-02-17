import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_state.dart';
import 'package:pr_alpr_upc/src/services/confidence_user_service.dart';
import 'package:pr_alpr_upc/src/utils/user_constants.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tab_container/tab_container.dart';

import '../../../models/confidence_user.dart';
import '../../../models/user.dart';
import 'add_confidenceuser_dialog.dart';

class UserTabContainer extends StatelessWidget {
  UserTabContainer({super.key});

  final formKey = GlobalKey<FormState>();
  final ConfidenceUserService confidenceUserService = ConfidenceUserService();

  @override
  Widget build(BuildContext context) {
    TemplateButtons templateButtons = TemplateButtons.instance;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return _buildTabContainer(context, templateButtons, state.user);
            } else {
              return Skeletonizer(child: _buildTabContainer(context, templateButtons, UserConstants.user));
            }
          },
        ),
      ),
    );
  }

  TabContainer _buildTabContainer(
      BuildContext context, TemplateButtons templateButtons, User user) {
    return TabContainer(
      controller: TabContainerController(
          length: 2, initialIndex: user.confidenceUsers.isEmpty ? 1 : 2),
      radius: 20,
      color: Theme.of(context).colorScheme.surface,
      tabs: const [
        'Usuarios\r\nde Confianza',
        'Solicitudes',
      ],
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildListViewConfidenceUser(
                  context, user.confidenceUsers),
            ),
          ],
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: buildListViewConfidenceRequest(
                  context, user.confidenceUsers),
            ),
            buildBottomAddButton(templateButtons, context)
          ],
        )
      ],
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
          templateButtons.createTertiaryButton('Enviar solicitud de confianza',
              () {
            showForm(context);
          }, context, 0.75)
        ],
      ),
    );
  }

  ListView buildListViewConfidenceUser(
      BuildContext context, List<ConfidenceUser> confidenceUsers) {
    return ListView(
      children: confidenceUsers
          .map((user) => _buildConfidenceUser(user, context))
          .toList(),
    );
  }

  ListView buildListViewConfidenceRequest(
      BuildContext context, List<ConfidenceUser> confidenceUsers) {
    return ListView(
      children: confidenceUsers
          .map((user) => _buildConfidenceRequest(user, context))
          .toList(),
    );
  }

  ListTile _buildConfidenceUser(
      ConfidenceUser confidenceUser, BuildContext context) {
    ConfidenceUserService confidenceUserService = ConfidenceUserService();
    //final userProvider = Provider.of<UserProvider>(context);

    return ListTile(
      title: Text(
        confidenceUser.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        confidenceUser.email,
        overflow: TextOverflow.ellipsis,
      ),
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
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          confidenceUserService.deleteConfidenceUser(confidenceUser.email);
        },
      ),
    );
  }

  ListTile _buildConfidenceRequest(
      ConfidenceUser confidenceUser, BuildContext context) {
    ConfidenceUserService confidenceUserService = ConfidenceUserService();
    //final userProvider = Provider.of<UserProvider>(context);

    return ListTile(
      title: Text(
        confidenceUser.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        confidenceUser.email,
        overflow: TextOverflow.ellipsis,
      ),
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.done,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              confidenceUserService.deleteConfidenceUser(confidenceUser.email);
            },
          ),
          IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                confidenceUserService
                    .deleteConfidenceUser(confidenceUser.email);
              })
        ],
      ),
    );
  }

  Future<void> showForm(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (context) => AddUserFormDialog(
              confidenceUserService:
                  ConfidenceUserService(), // Pasa tu instancia de servicio aquí
            ));
  }
}
