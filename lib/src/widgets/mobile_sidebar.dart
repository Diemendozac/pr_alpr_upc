import 'package:flutter/material.dart';

class MobileSideBar extends StatelessWidget {
  const MobileSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme
        .of(context)
        .textTheme
        .titleSmall;
    TextStyle? subtitleStyle = Theme
        .of(context)
        .textTheme
        .bodySmall;
    TextStyle? logOutTextStyle = Theme
        .of(context)
        .textTheme
        .titleSmall
        ?.copyWith(
        color: Theme
            .of(context)
            .colorScheme
            .secondary
    );

    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .onError,


      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('notification');
                  }, icon: const Icon(Icons.notifications_outlined))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          _buildUserHeader(context, titleStyle, subtitleStyle),
          const SizedBox(height: 30,),
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
                print('Log out');
              },
              child: Row(

                children: [
                  const SizedBox(width: 15,),
                  Text('Logout', style: logOutTextStyle),
                  Icon(Icons.logout, color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildUserHeader(BuildContext context, TextStyle? titleStyle,
      TextStyle? subtitleStyle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration:
      BoxDecoration(color: Theme
          .of(context)
          .colorScheme
          .surface),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildUserData(titleStyle, subtitleStyle, context),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface,
              ))
        ],
      ),
    );
  }

  Widget _buildUserData(TextStyle? title, TextStyle? subtitle,
      BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        _buildUserImage(),
        _buildUserStats(title, subtitle),
      ],
    );
  }

  Widget _buildUserImage() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: const ClipOval(
        child: FadeInImage(
          placeholder: AssetImage('assets/img/alert/background-alert-top.png'),
          image:
          NetworkImage('https://cdn.wallpapersafari.com/62/8/bc4hqG.jpg'),
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
