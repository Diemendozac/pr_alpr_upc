import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/utils/template_brand_images.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle _vehicle;

  const VehicleCard(this._vehicle, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(_vehicle.licensePlate);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildVehicleCharacteristics(context),
            _buildCardStylesheet(height * 0.136)
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCharacteristics(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.sports_motorsports_sharp,
                  size: 32, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(
                width: 10,
              ),
              Text(_vehicle.licensePlate.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Text(
            'FZ-150',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          _createDetails(context)
        ],
      ),
    );
  }

  Widget _buildCardStylesheet(double height) {
    return Container(
      decoration: const BoxDecoration(

      ),
      alignment: Alignment.center,
      //margin: EdgeInsets.only(right: 7.5),
      height: height,
      child: getBrandImage('pulsar'),
    );
  }

  Widget _createDetails(BuildContext context) {
    Color statsBackground = Theme.of(context).colorScheme.onError;

    TextStyle? statsStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.primary);

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(7.5),
            decoration: BoxDecoration(
                color: statsBackground, shape: BoxShape.rectangle),
            child: Text('150cc', style: statsStyle),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(7.5),
            decoration: BoxDecoration(
                color: statsBackground, shape: BoxShape.rectangle),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Color: ', style: statsStyle),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
