
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/theme_bloc/theme_bloc.dart';

import '../bloc/theme_bloc/theme_event.dart';
import '../bloc/theme_bloc/theme_state.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          icon: state.themeMode == ThemeMode.light
              ? const Icon(Icons.sunny)
              : const Icon(Icons.nightlight_round),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleTheme());
          },
        );
      },
    );
  }
}
