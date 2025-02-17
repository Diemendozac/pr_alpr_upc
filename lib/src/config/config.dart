
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get serverBaseUrl => dotenv.env['SERVER_BASE_URL'] ?? 'http://127.0.0.1:8080';//192.168.20.26:8080';
}