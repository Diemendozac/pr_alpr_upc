import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_state.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/vehicle_view.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/mobile_sidebar.dart';
import 'package:pr_alpr_upc/src/pages/home_page/components/tab_controller.dart';
import 'package:pr_alpr_upc/src/utils/user_constants.dart';
import 'package:pr_alpr_upc/src/widgets/state_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/user_bloc/user_event.dart';
import '../../bloc/vehicle_bloc/vehicle_bloc.dart';
import '../../bloc/vehicle_bloc/vehicle_state.dart';
import 'components/bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? vehiclesTitle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            );

    return StateOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const MobileSideBar(),
        appBar:
            AppBar(backgroundColor: Theme.of(context).colorScheme.background),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            FractionallySizedBox(
                widthFactor: 0.9,
                child: Text('Mis Vehículos',
                    style: vehiclesTitle, textAlign: TextAlign.left)),
            BlocListener<VehicleBloc, VehicleState>(
              listener: (context, state) {
                if (state is SuccessfulVehicleRequest) {
                  context.read<UserBloc>().add(UpdateUserVehicles(state.vehicles));
                }
              },
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return VehicleView(vehicles: state.user.vehicles);
                  } else {
                    return Skeletonizer(
                        enabled: true,
                        child:
                            VehicleView(vehicles: UserConstants.user.vehicles));
                  }
                },
              ),
            ),
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
          onTap: (number) {
            if (number == 0) Navigator.of(context).pushNamed('movements');
            if (number == 1) buildModalBottomSheet(context);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Movimientos',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Ajustes')
          ],
        ),
      ),
    );
  }

  void buildModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetWidget();
      },
    );
  }
}
