import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/services/google_auth_service.dart';
import 'package:pr_alpr_upc/src/services/locar_storage.dart';
import 'package:pr_alpr_upc/src/theme/theme_manager.dart';
import 'package:provider/provider.dart';

import '../providers/auth_state.dart';

class MobileSideBar extends StatelessWidget {
  const MobileSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    TextStyle? subtitleStyle = Theme.of(context).textTheme.bodySmall;
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
          _buildUserHeader(context, titleStyle, subtitleStyle),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {},
            title: Text('Opción0', style: titleStyle),
          ),
          ListTile(
            onTap: () {},
            title: Text('Opción1', style: titleStyle),
          ),
          ListTile(
            onTap: () {},
            title: Text('Ayuda', style: titleStyle),
          ),
          ListTile(
            onTap: () {},
            title: Text('Support', style: titleStyle),
          ),
          ListTile(
            onTap: () {},
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

  Container _buildUserHeader(
      BuildContext context, TextStyle? titleStyle, TextStyle? subtitleStyle) {
    ThemeManager themeManager = ThemeManager.instance;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildUserData(titleStyle, subtitleStyle, context),
          IconButton(
              onPressed: () => themeManager.toogleTheme(!LocalStorage.prefs.getBool("themeMode")!),
              icon: LocalStorage.prefs.getBool("themeMode")!
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode))
        ],
      ),
    );
  }

  Widget _buildUserData(
      TextStyle? title, TextStyle? subtitle, BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        _buildUserImage(),
        _buildUserStats(title, subtitle),
      ],
    );
  }

  Widget _buildUserImage() {
    String url = LocalStorage.prefs.getString("userPhotoUrl") ?? "https://cdn.wallpapersafari.com/62/8/bc4hqG.jpg";
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ClipOval(
        child: FadeInImage(
          placeholder: const AssetImage('assets/img/alert/background-alert-top.png'),
          image:
              NetworkImage(url),
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
      ),
    );
  }

  Widget _buildUserStats(TextStyle? title, TextStyle? subtitle) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Diego Mendoza',
            style: title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          Text(
            'diegoarmandomendoza@unicesar.edu.co',
            style: subtitle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
