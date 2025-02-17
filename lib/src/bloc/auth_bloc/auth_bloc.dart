import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  Timer? _tokenCheckTimer;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckTokenValidity>(_onCheckTokenValidity);

    _startTokenValidityCheck();
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(GoogleAuthShown());
    try {
      await authRepository.login();
      emit(Authenticated());
    } catch (e) {
      emit(AuthError("Login failed: ${e.toString()}"));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    _stopTokenValidityCheck();
    emit(Unauthenticated());
  }

  Future<void> _onCheckTokenValidity(CheckTokenValidity event, Emitter<AuthState> emit) async {
    final isValid = await authRepository.isTokenValid();
    if (!isValid) {
      emit(Unauthenticated());
      add(LogoutRequested());
    }
  }

  void _startTokenValidityCheck() {
    _tokenCheckTimer = Timer.periodic(const Duration(hours: 6), (timer) {
      add(CheckTokenValidity());
    });
  }

  void _stopTokenValidityCheck() {
    _tokenCheckTimer?.cancel();
  }

  @override
  Future<void> close() {
    _stopTokenValidityCheck();
    return super.close();
  }

  FutureOr<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(GoogleAuthShown());
    try {
      await authRepository.signUp();
      emit(SignUpCompleted("Usuario registrado con éxito"));
    } catch (e) {
      emit(AuthError("Login failed: ${e.toString()}"));
    }
  }
}

