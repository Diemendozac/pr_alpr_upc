
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/vehicle.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/vehicle_card.dart';
import 'vehicle_form.dart';

class VehicleView extends StatelessWidget {
  const VehicleView({super.key});

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);
    if(userProvider.getEmail() == null) userProvider.findLoggedInUser();

    List<Vehicle> vehicles = userProvider.getVehicles();
    List<VehicleCard> vehicleCards = vehicles.map((vehicle) => VehicleCard(vehicle)).toList();
    List<dynamic> userCards = [...vehicleCards];
    userCards.add(_buildAddVehicleCard(context));
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height * 0.3,
        child: PageView.builder(
          padEnds: false,
          controller: PageController(initialPage: 0, viewportFraction: 0.55),
          itemBuilder: (context, index) => userCards[index],
          itemCount: userCards.length,
        ),
      ),
    );

  }

  Widget _buildAddVehicleCard (BuildContext context) {

    final VehicleForm vehicleForm = VehicleForm();

    return GestureDetector(
      onTap: () {vehicleForm.showForm(context);},
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Container(
            height: 250,
            width: 125,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Icon(
                Icons.add,
                size: 90,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );

  }
}


