import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/utils/image_provider_helper.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../services/local_storage.dart';
import '../../../theme/theme_manager.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager.instance;

    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    TextStyle? subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildUserData(titleStyle, subtitleStyle, context),
          IconButton(
              onPressed: () => themeManager
                  .toogleTheme(!LocalStorage.prefs.getBool("themeMode")!),
              icon: LocalStorage.prefs.getBool("themeMode")!
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode))
        ],
      ),
    );
  }

  Widget _buildUserData(
      TextStyle? title, TextStyle? subtitle, BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Flex(
      direction: Axis.horizontal,
      children: [
        _buildUserImage(ImageProviderHelper.getImageProvider(userProvider)),
        _buildUserStats(title, subtitle, userProvider.getName()!, userProvider.getEmail()!),
      ],
    );
  }

  Widget _buildUserImage(ImageProvider imageProvider) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ClipOval(
        child: FadeInImage(
          placeholder: const AssetImage('assets/img/default-user.png'),
          image: imageProvider,
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
      ),
    );
  }

  Widget _buildUserStats(
      TextStyle? title, TextStyle? subtitle, String name, String email) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(name,
            style: title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          Text(
            email,
            style: subtitle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
