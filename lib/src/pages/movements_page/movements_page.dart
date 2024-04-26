
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/providers/movements_provider.dart';

import '../../models/ticket.dart';


class MovementsPage extends StatefulWidget {

  const MovementsPage({super.key});

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {

  List<Ticket> movements = [];

  @override
  Widget build(BuildContext context) {

    _findAllUserMovements();

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
                Text('Movimientos',
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
    MovementsProvider movementsProvider = MovementsProvider.instance;
    return ListView(
      children: movements.map((data) => _createNotificationListTile(data, context))
          .toList(),
    );
  }

  ListTile _createNotificationListTile(Ticket ticket, BuildContext context) {

    String title = ticket.plate;
    String subtitle = ticket.ownerEmail;
    String time = ticket.plate;

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

  Future<void> _findAllUserMovements () async {
    MovementsProvider movementsProvider = MovementsProvider.instance;
    List<Ticket> data = await movementsProvider.findAllParkedVehicles();
    if (data.isEmpty) return;
    setState(() {
      movements = data;
    });

  }

}
