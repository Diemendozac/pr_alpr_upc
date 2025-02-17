
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_check/animated_check.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pr_alpr_upc/src/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/vehicle_bloc/vehicle_state.dart';

class StateOverlay extends StatelessWidget {
  final Widget child;

  const StateOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleBloc, VehicleState>(
      listener: (context, state) {
        if (state is VehicleRequestLoading ) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: SpinKitFadingCube(
                  color: Theme.of(context).colorScheme.primary,
                  size: 100,
                ),
              );
            },
          );
        } else if (state is SuccessfulVehicleRequest) {
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: AnimatedCheck(
                  progress: const AlwaysStoppedAnimation<double>(1),
                  size: 200,
                ),
              );
            },
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(); // Close the dialog
          });
        }
      },
      child: child,
    );
  }
}
