import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/utils/form_constants.dart';

import '../models/vehicle.dart';

class VehicleForm {
  final _formKey = GlobalKey<FormState>();
  final FormConstants formConstants = FormConstants();

  Future<void> showForm(BuildContext context, [Vehicle? vehicle]) async {
    Color primaryColor = Theme.of(context).colorScheme.primary;

    List<String> brandOptions = formConstants.brandOptions;
    List<String> modelOptions = formConstants.modelOptions;

    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
              title: const Text('Modifica tu vehículo'),
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
                          _buildTextFormInput('Placa', context),
                          _buildTextFormInput('Línea', context),
                          _buildPaddingWidget(dropdownButtonFormField(
                              context, brandOptions, 'Marca')),
                          _buildPaddingWidget(Row(
                            children: [
                              Expanded(
                                  child: dropdownButtonFormField(
                                      context, modelOptions, 'Modelo')),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: dropdownButtonFormField(
                                      context, brandOptions, 'Color')),
                            ],
                          )),
                          _buildFormButton(primaryColor, 'Editar Vehículo'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  DropdownButtonFormField<String> dropdownButtonFormField(
      BuildContext context, List<String> options, String placeHolder) {
    return DropdownButtonFormField(
        decoration: _buildInputDecoration(context, placeHolder),
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

  Padding _buildFormButton(Color primaryColor, String text) {
    ElevatedButton formButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          print('Ok');
        }
      },
      child: Text(text),
    );

    return _buildPaddingWidget(formButton);
  }

  Widget _buildTextFormInput(String label, BuildContext context) {
    return _buildPaddingWidget(TextFormField(
        decoration: _buildInputDecoration(context, label),
        validator: (value) {return formConstants.validatePlate(value);}));
  }

  Padding _buildPaddingWidget(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: widget,
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context, String label) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color errorColor = Theme.of(context).colorScheme.error;
    BorderRadius inputBorders = const BorderRadius.all(Radius.circular(10));
    TextStyle errorStyle = Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: errorColor, fontWeight: FontWeight.w100, fontSize: 12);

    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: inputBorders),
      focusedBorder: OutlineInputBorder(
        borderRadius: inputBorders,
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      errorStyle: errorStyle,
      errorBorder: OutlineInputBorder(
          borderRadius: inputBorders,
          borderSide: BorderSide(color: errorColor)),
    );
  }
}
