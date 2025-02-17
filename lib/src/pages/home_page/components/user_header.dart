import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_state.dart';
import 'package:pr_alpr_upc/src/utils/image_provider_helper.dart';
import 'package:pr_alpr_upc/src/utils/user_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../models/user.dart';
import '../../../widgets/theme_toggle_button.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    TextStyle? subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return _buildUserData(
                    titleStyle, subtitleStyle, context, state.user);
              } else {
                return Skeletonizer(
                  enabled: true,
                    child: _buildUserData(titleStyle, subtitleStyle, context,
                        UserConstants.user));
              }
            },
          ),
          const ThemeToggleButton()
        ],
      ),
    );
  }

  Widget _buildUserData(
      TextStyle? title, TextStyle? subtitle, BuildContext context, User user) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        _buildUserImage(ImageProviderHelper.getImageProvider(user.urlPhoto)),
        _buildUserStats(title, subtitle, user.name, user.email),
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
          Text(
            name,
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
