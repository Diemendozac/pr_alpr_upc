import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUserData>(_onLoadUserData);
    on<UpdateUserData>(_onUpdateUserData);
    on<UserSignOutRequested>(_onUserSignOutRequested);
    on<UpdateUserVehicles>(_onUpdateUserVehicles);
  }

  Future<void> _onLoadUserData(LoadUserData event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final userData = await userRepository.fetchUserData();
      emit(UserLoaded(userData));
    } catch (e) {
      emit(UserError("Failed to load user data: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateUserData(UpdateUserData event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final updatedData = await userRepository.updateUserData(event.updatedData);
      emit(UserLoaded(updatedData));
    } catch (e) {
      emit(UserError("Failed to update user data: ${e.toString()}"));
    }
  }

  Future<void> _onUserSignOutRequested(UserSignOutRequested event, Emitter<UserState> emit) async {
    emit(UserInitial());
  }

  void _onUpdateUserVehicles(UpdateUserVehicles event, Emitter<UserState> emit) {
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      final updatedUser = currentUser.copyWith(vehicles: event.vehiclesToUpdate);
      emit(UserLoaded(updatedUser));
    }
  }
}
