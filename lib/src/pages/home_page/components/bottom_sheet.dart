
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  BottomSheetWidgetState createState() => BottomSheetWidgetState();
}

class BottomSheetWidgetState extends State<BottomSheetWidget> {
  bool _enableNotifications = false;
  bool _rememberSession = false;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;
    TextStyle subtitleStyle = Theme.of(context).textTheme.titleSmall!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Configuración',
            style: titleStyle,
          ),
          const SizedBox(height: 20.0),
          ListTile(
            title: Text(
              'Notificaciones',
              style: subtitleStyle,
            ),
            trailing: _buildSwitch(_enableNotifications ,_setEnableNotifications),
          ),
          ListTile(
            title: Text('Recordar sesión', style: subtitleStyle),
            trailing: _buildSwitch(_rememberSession, _setRememberSession),
          ),
        ],
      ),
    );
  }

  Switch _buildSwitch(bool value, Function(bool) setter) {
    Color inactiveColor = Theme.of(context).colorScheme.onSurface;
    Color activeColor = Theme.of(context).colorScheme.primary;

    return Switch(
      inactiveThumbColor: inactiveColor,
      trackOutlineColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return activeColor;
        return inactiveColor;

      }),
      value: value,
      onChanged: (value) {
        setState(() {
          setter(value);
        });
      },
    );
  }

  void _setEnableNotifications (bool value){
    _enableNotifications = value;
  }

  void _setRememberSession (bool value){
    _rememberSession = value;
  }
}
