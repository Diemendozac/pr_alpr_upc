
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/ticket.dart';
import '../services/ticket_service.dart';

class MovementsProvider with ChangeNotifier {

  final ticketService = TicketService();

  MovementsProvider._();

  static MovementsProvider instance = MovementsProvider._();

  Future<List<Ticket>> findAllParkedVehicles() async {
    var response = await ticketService.findAllUserTickets();
    if (response.statusCode == 200) {
      List<dynamic> mapData = jsonDecode(response.body);
      List<Ticket> userTickets = mapData.map<Ticket>((map) => Ticket.fromJson(map)).toList();
      return userTickets;
    }
    return [];

  }
}
