import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/theme_bloc/theme_event.dart';
import 'package:pr_alpr_upc/src/bloc/theme_bloc/theme_state.dart';

import '../../repositories/theme_repository.dart';

// Eventos para el tema.

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository themeRepository;

  ThemeBloc({required this.themeRepository})
      : super(ThemeState(themeMode: ThemeMode.light)) {
    // Cargar la preferencia al iniciar
    on<LoadTheme>((event, emit) async {
      final mode = await themeRepository.getThemeMode();
      emit(ThemeState(themeMode: mode));
    });

    // Alternar tema y persistir la elección
    on<ToggleTheme>((event, emit) async {
      final newMode = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
      await themeRepository.setThemeMode(newMode);
      emit(ThemeState(themeMode: newMode));
    });
  }
}
