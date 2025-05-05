import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Registrar el observer para detectar cambios de teclado
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Eliminar el observer cuando se destruye el widget
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Optimizar las animaciones cuando cambia el teclado
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Verificar si el teclado está visible
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0) {
      // Desactivar animaciones cuando el teclado está visible
      SystemChannels.textInput.invokeMethod('TextInput.setAnimationDisabled', true);
    } else {
      // Reactivar animaciones cuando el teclado se oculta
      SystemChannels.textInput.invokeMethod('TextInput.setAnimationDisabled', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usar colores del tema para soportar modo oscuro
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    TextStyle? vehiclesTitle = theme.textTheme.titleMedium?.copyWith(
      color: colorScheme.onSurface,
    );

    return StateOverlay(
      child: Scaffold(
        // Usar el parámetro que evita problemas de teclado
        resizeToAvoidBottomInset: false, // Volver a false para evitar problemas de layout
        drawer: const MobileSideBar(),
        appBar: AppBar(backgroundColor: colorScheme.background),
        backgroundColor: colorScheme.background,
        // Usar LayoutBuilder para mejor control del layout
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SafeArea(
              child: Column(
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
                              child: VehicleView(vehicles: UserConstants.user.vehicles));
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
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: colorScheme.onSurface,
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
    // Optimizar la animación del BottomSheet
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      // Usar curva personalizada para animación más rápida
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: Navigator.of(context),
      ),
      builder: (BuildContext context) {
        return const BottomSheetWidget();
      },
    );
  }
}