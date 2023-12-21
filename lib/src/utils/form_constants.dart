
class FormConstants {

  List<String> brandOptions = [
    'Suzuki',
    'Yamaha',
    'KTM',
    'Bajaj',
    'Hero',
    'Kawasaki'
  ];

  List<String> modelOptions = [
    for (var i = 2024; i > 1990; i -= 1) i.toString()
  ];
  RegExp plateRegex = RegExp('[a-z]{3}([0-9]){2}([a-z0-9]{1})');

  String? validatePlate(String? plate) {

    plate = plate!.toLowerCase();

    if ( plate.isEmpty) {
      return 'Campo obligatorio';
    }

    if(!plateRegex.hasMatch(plate)) {
      return 'Ingrese un dato válido';
    }
    return null;
  }

  String? validateSelectedValue(String? value) {

    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    return null;
  }

}