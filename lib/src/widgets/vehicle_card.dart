import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/widgets/vehicle_form.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle _vehicle;

  const VehicleCard(this._vehicle, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: _buildCardContent(context),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {

    final VehicleForm vehicleForm = VehicleForm();

    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        );

    TextStyle? subtitleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        );

    Color iconsColor = Theme.of(context).colorScheme.onPrimary;

    return Container(
      height: 250,
      width: 125,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.sports_motorsports, color: iconsColor),
              GestureDetector(
                  child: Icon(Icons.edit, color: iconsColor,),
                onTap: () {vehicleForm.showForm(context);},
              )
            ],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABC-23C',
                  style: titleStyle,
                ),
                Text(
                  'Yamaha FZ-150',
                  style: subtitleStyle,
                )
              ],
            ),
          ),
          _buildVehicleStats(context),
        ],
      ),
    );
  }

  Widget _buildVehicleStats(BuildContext context) {
    TextStyle? statsStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w200);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onError,
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(7.5),
          child: Text(
            '2022',
            style: statsStyle,
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onError,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(7.5),
            child: Row(
              children: [
                Text(
                  'Color: ',
                  style: statsStyle,
                ),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red),
                )
              ],
            ))
      ],
    );
  }
}
