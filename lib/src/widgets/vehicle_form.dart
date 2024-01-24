import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/services/vehicle_service.dart';
import 'package:pr_alpr_upc/src/utils/form_constants.dart';

import '../models/vehicle.dart';

class VehicleForm {
  final _formKey = GlobalKey<FormState>();
  final VehicleService vehicleService = VehicleService();
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
    Color primaryColor = Theme.of(context).colorScheme.primary;

    List<String> brandOptions = formConstants.brandOptions;
    List<String> modelOptions = formConstants.modelOptions;

    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              scrollable: true,
              title: buildFormTitle(vehicle, context),
              titlePadding: const EdgeInsets.only(left: 30, top: 20),
              content: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildTextFormInput('Placa', context,
                              formConstants.validatePlate, setPlate, vehicle?.plate, vehicle == null),
                          _buildTextFormInput('Línea', context,
                              formConstants.validateSelectedValue, setLine, vehicle?.line, true),
                          _buildPaddingWidget(buildDropdownButtonFormField(
                              context, brandOptions, 'Marca', setBrand, vehicle?.brand)),
                          _buildPaddingWidget(Row(
                            children: [
                              Expanded(
                                  child: buildDropdownButtonFormField(context,
                                      modelOptions, 'Modelo', setModel, vehicle?.model.toString())),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: buildDropdownButtonFormField(context,
                                      brandOptions, 'Color', setColor, vehicle?.color)),
                            ],
                          )),
                          _buildFormButton(primaryColor, vehicle == null),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget buildFormTitle(Vehicle? vehicle, BuildContext context) {

    bool vehicleIsNull = vehicle == null;
    Widget createTitle = const Text('Añade tu vehículo');
    if (vehicleIsNull) return createTitle;

    Widget modifyTitle = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Modifica tu vehículo'),
        IconButton(
            onPressed: () {
              vehicleService.deleteVehicle(vehicle.plate);
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.secondary,
            ))
      ],
    );

    return modifyTitle;
  }

  DropdownButtonFormField<String> buildDropdownButtonFormField(BuildContext context,
      List<String> options, String placeHolder, Function(String) setter, String? initialValue) {

    return DropdownButtonFormField(
      value: initialValue,
        onSaved: (String? value) {
          setter(value!);
        },
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
                )))
            .toList(),
        onChanged: (opt) => print(opt));
  }

  Widget _buildTextFormInput(String label, BuildContext context,
      Function(String?) validator, Function(String) setter, String? initialVehicleValue, bool setEnabled) {
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

  Padding _buildFormButton(Color primaryColor, bool isSave) {
    String text = isSave ? 'Añade' : 'Modifica';
    ElevatedButton formButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          Vehicle requestVehicle = Vehicle(
              brand: _brand,
              color: _color,
              line: _line,
              model: _model,
              plate: _plate,
              isOwner: true);
          bool? httpResponse = isSave ? await vehicleService.saveVehicle(requestVehicle) :
              await vehicleService.updateVehicle(requestVehicle);
          print(httpResponse);
        }

      },
      child: Text('$text Vehículo'),
    );

    return _buildPaddingWidget(formButton);
  }
}
