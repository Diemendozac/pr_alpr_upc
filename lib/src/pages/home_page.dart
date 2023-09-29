import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/providers/vehicle_provider.dart';
import 'package:pr_alpr_upc/src/widgets/mobile_sidebar.dart';
import 'package:pr_alpr_upc/src/widgets/vehicle_card.dart';

import '../models/vehicle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: const MobileSideBar(),
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          _buildVehiclePageView(context),
        ],
      ),
    );
  }
  
  Widget _buildVehiclePageView(BuildContext context) {
    
    List<Vehicle> vehicles = VehicleProvider().userVehicles;
    double height = MediaQuery.of(context).size.height;
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height * 0.275,
      child: StretchingOverscrollIndicator(
        axisDirection: AxisDirection.left,
        child: PageView.builder(

          itemBuilder: (context, index) => VehicleCard(vehicles[index]),
          itemCount: vehicles.length,

        ),
      ),
    );
    
  }

}
