import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/providers/vehicle_provider.dart';
import 'package:pr_alpr_upc/src/widgets/mobile_sidebar.dart';
import 'package:pr_alpr_upc/src/widgets/tab_controller.dart';
import 'package:pr_alpr_upc/src/widgets/vehicle_card.dart';


import '../models/vehicle.dart';

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
          _buildVehiclePageView(context),
          FractionallySizedBox(
              widthFactor: 0.9,
              child: Text('Círculo de confianza',
                  style: vehiclesTitle, textAlign: TextAlign.left)),
          const UserTabContainer()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Movimientos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes')
        ],
      ),
    );
  }

  Widget _buildVehiclePageView(BuildContext context) {

    List<Vehicle> vehicles = VehicleProvider().userVehicles;
    List<VehicleCard> vehicleCards = vehicles.map((vehicle) => VehicleCard(vehicle)).toList();
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height * 0.3,
      child: PageView.builder(
        padEnds: false,
        controller: PageController(initialPage: 0, viewportFraction: 0.55),
        itemBuilder: (context, index) => vehicleCards[index],
        itemCount: vehicles.length,
      ),
    );
  }

}
