import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/vehicle_view.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/mobile_sidebar.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/tab_controller.dart';

import 'components/bottom_sheet.dart';


class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle? vehiclesTitle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MobileSideBar(),
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.background),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          FractionallySizedBox(
              widthFactor: 0.9,
              child: Text('Mis Vehículos',
                  style: vehiclesTitle, textAlign: TextAlign.left)),
          const VehicleView(),
          FractionallySizedBox(
              widthFactor: 0.9,
              child: Text('Círculo de confianza',
                  style: vehiclesTitle, textAlign: TextAlign.left)),
          UserTabContainer()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (number){
          if(number == 0) Navigator.of(context).pushNamed('movements');
          if(number == 1) buildModalBottomSheet(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Movimientos',),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes')
        ],
      ),
    );

  }

  void buildModalBottomSheet (BuildContext context) {

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetWidget();
      },
    );

  }



}
