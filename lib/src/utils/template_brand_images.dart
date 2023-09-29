import 'package:flutter/material.dart';

final _images = <String, ImageProvider> {

  'yamaha'     : const AssetImage('assets/img/brands/yamaha.png'),
  'pulsar'     : const AssetImage('assets/img/brands/pulsar.png'),
  'bajaj'      : const AssetImage('assets/img/brands/bajaj.png'),


};


Image getBrandImage (String brandName) {

  return Image(image: _images[brandName] ?? const AssetImage(''), width: 200, alignment: Alignment.center,);
}