
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<void> login() async {
    final authData = await authService.signInWithGoogle();
    String? token = authData?['token'];
    if ( token != null ) await authService.saveToken(token);
  }

  Future<void> signUp() async {
    await authService.signUpWithGoogle();

  }

  Future<bool> isTokenValid() async {
    final token = await authService.getToken();
    if (token == null) return false;
    return await authService.verifyToken(token);
  }

  Future<void> logout() async {
    await authService.signOut();
  }

}
