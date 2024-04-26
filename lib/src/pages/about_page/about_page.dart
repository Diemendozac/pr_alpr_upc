import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre CampusGate',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Acerca de nuestra aplicación',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Esta aplicación fue desarrollada para apoyar a la empresa Nevada de '
              'Seguridad en la gestión de vehículos motorizados en el campus de la '
              'Universidad Popular del Cesar',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Créditos de imágenes:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Algunas imágenes utilizadas en esta aplicación fueron diseñadas por Freepik. Puedes encontrar más recursos en su página web:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            InkWell(
                child: const Text(
                  'www.freepik.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () async {await _launchUrl();}
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {

    final Uri _url = Uri.parse('https://www.freepik.com');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}
