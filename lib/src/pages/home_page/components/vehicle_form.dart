import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/utils/form_constants.dart';
import 'package:pr_alpr_upc/src/widgets/buttons.dart';

import '../../../bloc/vehicle_bloc/vehicle_bloc.dart';
import '../../../bloc/vehicle_bloc/vehicle_event.dart';
import '../../../bloc/vehicle_bloc/vehicle_state.dart';
import '../../../models/color_enum.dart';
import '../../../models/vehicle.dart';

class VehicleForm {
  final _formKey = GlobalKey<FormState>();
  late String _plate;
  late String _line;
  late String _brand;
  late int _model;
  late String _color;

  final FormConstants formConstants = FormConstants();

  void setColor(String value) {
    _color = value;
  }

  void setModel(String value) {
    _model = int.parse(value);
  }

  void setBrand(String value) {
    _brand = value;
  }

  void setLine(String value) {
    _line = value;
  }

  void setPlate(String value) {
    _plate = value.toUpperCase();
  }

  Future<void> showForm(BuildContext context, [Vehicle? vehicle]) async {
    // Obtener tema para soportar modo oscuro
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    List<String> brandOptions = formConstants.brandOptions;
    List<String> modelOptions = formConstants.modelOptions;

    // SOLUCIÓN RADICAL: Desactivar completamente las animaciones del teclado
    // antes de mostrar el formulario
    SystemChannels.textInput.invokeMethod('TextInput.setAnimationDisabled', true);

    try {
      // Volvemos al BottomSheet pero con optimizaciones
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        // Usar un controlador de animación personalizado extremadamente rápido
        transitionAnimationController: AnimationController(
          // Duración muy corta para evitar demoras perceptibles
          duration: const Duration(milliseconds: 50),
          vsync: Navigator.of(context),
        ),
        // Agregar esto para que el BottomSheet se muestre inmediatamente sin esperar a que el teclado aparezca
        enableDrag: false,
        builder: (BuildContext context) {
          return Container(
            // Usar padding que se ajusta inmediatamente al teclado
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              // Usar color del tema para soportar modo oscuro
              color: colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            // Limitar altura máxima
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: SingleChildScrollView(
              // Física sin rebote para mejor rendimiento
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título del formulario
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vehicle == null ? 'Añade tu vehículo' : 'Modifica tu vehículo',
                            // Usar titleMedium como solicitó
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          if (vehicle != null)
                            IconButton(
                              onPressed: () {
                                if (context.read<VehicleBloc>().state is! VehicleRequestLoading) {
                                  context.read<VehicleBloc>().add(DeleteVehicleRequested(vehicle.plate));
                                  Navigator.pop(context, true);
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: colorScheme.secondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Formulario
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildTextFormInput(
                              'Placa',
                              context,
                              formConstants.validatePlate,
                              setPlate,
                              vehicle?.plate,
                              vehicle == null),
                          _buildTextFormInput(
                              'Línea',
                              context,
                              formConstants.validateSelectedValue,
                              setLine,
                              vehicle?.line,
                              true),
                          _buildPaddingWidget(buildDropdownButtonFormField(
                              context,
                              brandOptions,
                              'Marca',
                              setBrand,
                              vehicle?.brand)),
                          // Solución al problema de responsividad
                          _buildPaddingWidget(_buildResponsiveDropdowns(
                              context,
                              modelOptions,
                              colors,
                              setModel,
                              setColor,
                              vehicle?.model.toString(),
                              vehicle?.color)),
                          const SizedBox(height: 16),
                          // Botón de guardar
                          SizedBox(
                            width: double.infinity,
                            child: TemplateButtons.createPrimaryButton(
                                vehicle == null ? 'Añadir Vehículo' : 'Modificar Vehículo', () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Vehicle requestVehicle = Vehicle(
                                    brand: _brand,
                                    color: _color,
                                    line: _line,
                                    model: _model,
                                    plate: _plate,
                                    isOwner: true);
                                if (vehicle == null) {
                                  context.read<VehicleBloc>().add(SaveVehicleRequested(requestVehicle));
                                } else {
                                  context.read<VehicleBloc>().add(UpdateVehicleRequested(requestVehicle));
                                }
                                Navigator.pop(context, true);
                              }
                            }, context, double.infinity),
                          ),
                          const SizedBox(height: 8),
                          // Botón de cancelar
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: colorScheme.primary,
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancelar',
                                style: TextStyle(color: colorScheme.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } finally {
      // Reactivar las animaciones del teclado al cerrar
      SystemChannels.textInput.invokeMethod('TextInput.setAnimationDisabled', false);
    }
  }

  // Widget para los dropdowns responsivos
  Widget _buildResponsiveDropdowns(
      BuildContext context,
      List<String> modelOptions,
      List<String> colorOptions,
      Function(String) setModel,
      Function(String) setColor,
      String? initialModelValue,
      String? initialColorValue) {
    // Para pantallas pequeñas, colocamos los dropdowns en columna
    if (MediaQuery.of(context).size.width < 360) {
      return Column(
        children: [
          buildDropdownButtonFormField(
              context, modelOptions, 'Modelo', setModel, initialModelValue),
          const SizedBox(height: 10),
          buildDropdownButtonFormField(
              context, colorOptions, 'Color', setColor, initialColorValue),
        ],
      );
    }

    // Para pantallas más grandes, usamos Row con Flexible
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: buildDropdownButtonFormField(
              context, modelOptions, 'Modelo', setModel, initialModelValue),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 1,
          child: buildDropdownButtonFormField(
              context, colorOptions, 'Color', setColor, initialColorValue),
        ),
      ],
    );
  }

  DropdownButtonFormField<String> buildDropdownButtonFormField(
      BuildContext context,
      List<String> options,
      String placeHolder,
      Function(String) setter,
      String? initialValue) {
    return DropdownButtonFormField(
      value: initialValue,
      onSaved: (String? value) {
        setter(value!);
      },
      isExpanded: true, // Prevenir overflow
      decoration: formConstants.buildInputDecoration(context, placeHolder),
      validator: (value) {
        return formConstants.validateSelectedValue(value);
      },
      items: options
          .map((opt) => DropdownMenuItem(
        value: opt,
        child: Text(
          opt,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      ))
          .toList(),
      onChanged: (opt) => (opt),
    );
  }

  Widget _buildTextFormInput(
      String label,
      BuildContext context,
      Function(String?) validator,
      Function(String) setter,
      String? initialVehicleValue,
      bool setEnabled) {
    return _buildPaddingWidget(TextFormField(
        initialValue: initialVehicleValue,
        enabled: setEnabled,
        onSaved: (String? value) {
          setter(value!);
        },
        decoration: formConstants.buildInputDecoration(context, label),
        validator: (value) {
          return validator(value);
        }));
  }

  Padding _buildPaddingWidget(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: widget,
    );
  }
}