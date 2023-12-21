import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/providers/notification_provider.dart';


class NotificationPage extends StatelessWidget {

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _createHeader(context),
          Expanded(child: _createNotifications(context)),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 25),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.arrow_back)),
            SizedBox(height: height * 0.075),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notificaciones',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createNotifications(BuildContext context) {
    NotificationProvider userProvider = NotificationProvider();
    List<Map<String, String>> notifications =
        userProvider.getUserNotifications();

    return ListView(
      children: notifications
          .map((data) => _createNotificationListTile(data, context))
          .toList(),
    );
  }

  ListTile _createNotificationListTile(Map data, BuildContext context) {
    String title = data['title'];
    String subtitle = data['subtitle'];
    String time = data['time'];

    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      fontSize: 17
    );

    TextStyle? hourStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        fontSize: 15,
      color: Theme.of(context).colorScheme.secondary
    );

    return ListTile(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: titleStyle
      ),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(time,
          overflow: TextOverflow.ellipsis,
          style: hourStyle,
      ),
    );
  }
}
