import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/user_header.dart';
import 'package:pr_alpr_upc/src/services/google_auth_service.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_state.dart';

class MobileSideBar extends StatelessWidget {
  const MobileSideBar({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    TextStyle? logOutTextStyle = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(color: Theme.of(context).colorScheme.secondary);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('notification');
                  },
                  icon: const Icon(Icons.notifications_outlined)),
              const SizedBox(width: 10,)
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const UserHeader(),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {Navigator.of(context).pushNamed('user_profile');},
            title: Text('Datos de Usuario', style: titleStyle),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'user_guide');
            },
            title: Text('Manual de Usuario', style: titleStyle),
          ),
          ListTile(
            onTap: () {},
            title: Text('Support', style: titleStyle),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed('about'),
            title: Text('Acerca de', style: titleStyle),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                GoogleAuthService authService = GoogleAuthService.instance;
                authService.eraseUserData();
                final authState = context.read<AuthState>();
                authState.logOutUser();
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text('Logout', style: logOutTextStyle),
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


