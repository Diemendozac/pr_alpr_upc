import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pr_alpr_upc/src/models/color_enum.dart';
import 'package:pr_alpr_upc/src/models/vehicle.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/vehicle_form.dart';

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
              SvgPicture.asset(
                'assets/img/helmet.svg',
                width: 30,
                height: 30,

              ),
              _vehicle.isOwner ? IconButton(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                icon: Icon(Icons.edit, color: iconsColor,  ),
                onPressed: () {vehicleForm.showForm(context, _vehicle);},
              ) : Container()
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _vehicle.plate,
                style: titleStyle,
              ),
              Text(
                _vehicle.line,
                style: subtitleStyle,
              )
            ],
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
            _vehicle.model.toString(),
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
                  _vehicle.color ?? 'Color: ',
                  style: statsStyle,
                ),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: getColor(_vehicle.color?? 'AZUL')),
                )
              ],
            ))
      ],
    );
  }
}
