
import 'package:flutter/material.dart';

class TemplateForms {
  final _formKey = GlobalKey<FormState>();

  Future<void> vehicleForm(BuildContext context) async {
    Color primaryColor = Theme.of(context).colorScheme.primary;

    List<String> brandOptions = [
      'Suzuki',
      'Yamaha',
      'KTM',
      'Bajaj',
      'Hero',
       'Kawasaki'
    ];
    List<String> modelOptions = [for(var i=2024; i > 1990; i-=1) i.toString()];

    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Modifica tu vehículo'),
              titlePadding: const EdgeInsets.only(left: 30, top: 20),
              content: Stack(
                clipBehavior: Clip.none,
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
                          _buildPaddingWidget(
                              dropdownButtonFormField(context, brandOptions, 'Marca')),
                          _buildPaddingWidget(Row(
                            children: [
                              Expanded(child: dropdownButtonFormField(context, modelOptions, 'Modelo')),
                              const SizedBox(width: 10,),
                              Expanded(child: dropdownButtonFormField(context, brandOptions, 'Color')),
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
        }
      },
      child: Text(text),
    );

    return _buildPaddingWidget(formButton);
  }

  Widget _buildTextFormInput(String label, BuildContext context) {
    return _buildPaddingWidget(
        TextFormField(decoration: _buildInputDecoration(context, label)));
  }

  Padding _buildPaddingWidget(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: widget,
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context, String label) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color onSurfaceColor = Theme.of(context).colorScheme.onSurface;

    return InputDecoration(
      labelText: label,
      fillColor: Colors.grey,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: onSurfaceColor,
        ),
      ),
    );
  }
}
