

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'local_storage.dart';

class TicketService {

  final String baseUrl = LocalStorage.prefs.getString('baseUrl')!;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<dynamic> findAllUserTickets() async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.get(
      Uri.parse('$baseUrl/ticket/find-all'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios");
    }

    return response;
  }

}
