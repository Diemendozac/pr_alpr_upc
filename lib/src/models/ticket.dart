

class Ticket {
  String plate;
  String userName;
  String ownerEmail;
  DateTime timeStamp;
  bool isIngresing;

  Ticket({
    required this.plate,
    required this.userName,
    required this.ownerEmail,
    required this.timeStamp,
    required this.isIngresing,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      plate: json["plate"],
      userName: json["userName"],
      ownerEmail: json["ownerEmail"],
      timeStamp: json["timeStamp"],
      isIngresing: json["isIngresing"],
    );
  }
}
