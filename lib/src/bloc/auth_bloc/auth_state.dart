abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class GoogleAuthShown extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class SignUpCompleted extends AuthState {
  final String message;

  SignUpCompleted(this.message);
}

