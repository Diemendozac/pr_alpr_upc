
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pr_alpr_upc/src/providers/user_provider.dart';
import 'dart:convert';

import '../models/confidence_user.dart';
import 'local_storage.dart';

class ConfidenceRequestService {

  final String baseUrl = LocalStorage.prefs.getString('baseUrl')!;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final UserProvider _userProvider = UserProvider.instance;

  Future<List<ConfidenceUser>>getConfidenceCircle() async {

    var response = await http.get(Uri.parse("$baseUrl/confidence-request"));

    // Comprueba el estado de la respuesta
    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios");
    }

    // Decodifica los datos de la respuesta
    List<ConfidenceUser> confidenceCircle = List<ConfidenceUser>.from(
        jsonDecode(response.body).map((c) => ConfidenceUser.fromJson(c)));

    return confidenceCircle;
  }

  Future<dynamic> addConfidenceUser(String confidenceUserEmail) async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.post(
      Uri.parse('$baseUrl/add?email=$confidenceUserEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) refreshConfidenceRequests(response.body);
    return response;
  }

  Future<dynamic> deleteConfidenceUser(String confidenceUserEmail) async {

    String? token = await _storage.read(key: 'token');
    if(token == null) return null;

    var response = await http.delete(
      Uri.parse('$baseUrl/delete?email=$confidenceUserEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) refreshConfidenceRequests(response.body);
    return response;
  }

  void refreshConfidenceRequests(String body) {

    List<dynamic> mapData = jsonDecode(body);

    List<ConfidenceUser> confidenceUsers = [];
    try {
      confidenceUsers = mapData.map<ConfidenceUser>((map) => ConfidenceUser.fromJson(map))
          .toList();
    } catch (e) {
      confidenceUsers = [];
    } finally {
      _userProvider.setConfidenceUsers(confidenceUsers);
    }

  }

}
