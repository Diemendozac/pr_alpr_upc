import 'dart:convert';

class ResponseModel {
  String timeStamp;
  String message;
  int status;
  String data;

  ResponseModel({
    required this.timeStamp,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> jsonData) {
    return ResponseModel(
      timeStamp: jsonData["TimeStamp"].toString(),
      message: jsonData["Message"].toString(),
      status: jsonData["Status"],
      data: jsonData["Data"].toString(),
    );
  }
}
