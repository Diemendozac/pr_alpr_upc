abstract class AuthEvent {}

class LoginRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class CheckTokenValidity extends AuthEvent {}

