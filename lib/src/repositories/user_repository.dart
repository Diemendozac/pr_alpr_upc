import 'package:pr_alpr_upc/src/services/auth_service.dart';

import '../services/user_service.dart';
import '../models/user.dart';

class UserRepository {
  final UserService userService;
  final AuthService authService = AuthService();

  UserRepository({required this.userService});

  Future<User> fetchUserData() async {
    try {
      final token = await authService.getToken();
      if (token == null ) throw Exception('Tuvimos problemas con la autenticación. Intente nuevamente');
      final data = await userService.fetchData(token);
      return User.fromJson(data);
    } catch (e) {
      throw Exception("Error al obtener los datos del usuario: $e");
    }
  }

  /// Actualiza los datos del usuario
  Future<User> updateUserData(Map<String, dynamic> updatedData) async {
    try {
      final token = await authService.getToken();
      if (token == null) throw Exception("Token no encontrado.");
      final data = await userService.updateData(token, updatedData);
      return User.fromJson(data);
    } catch (e) {
      throw Exception("Error al actualizar los datos del usuario: $e");
    }
  }
}

