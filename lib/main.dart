import 'package:auth_state_manager/auth_state_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/theme_bloc/theme_event.dart';
import 'package:pr_alpr_upc/src/bloc/theme_bloc/theme_state.dart';
import 'package:pr_alpr_upc/src/bloc/user_bloc/user_bloc.dart';
import 'package:pr_alpr_upc/src/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:pr_alpr_upc/src/pages/about_page/about_page.dart';
import 'package:pr_alpr_upc/src/pages/movements_page/movements_page.dart';
import 'package:pr_alpr_upc/src/pages/user_guide_page/user_guide_page.dart';
import 'package:pr_alpr_upc/src/pages/user_profile_page/user_profile_page.dart';
import 'package:pr_alpr_upc/src/repositories/auth_repository.dart';
import 'package:pr_alpr_upc/src/repositories/user_repository.dart';
import 'package:pr_alpr_upc/src/repositories/vehicle_repository.dart';
import 'package:pr_alpr_upc/src/services/auth_service.dart';
import 'package:pr_alpr_upc/src/services/local_storage.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:pr_alpr_upc/src/services/vehicle_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/config/firebase_options.dart';
import 'package:pr_alpr_upc/src/pages/alert/alert_page.dart';
import 'package:pr_alpr_upc/src/pages/home_page/home_page.dart';
import 'package:pr_alpr_upc/src/pages/login_page/login_page.dart';
import 'package:pr_alpr_upc/src/pages/initial_page/initial_page.dart';
import 'package:pr_alpr_upc/src/pages/notification_page/notification_page.dart';
import 'package:pr_alpr_upc/src/repositories/theme_repository.dart';
import 'package:pr_alpr_upc/src/theme/theme_constans.dart'; // lightTheme, darkTheme
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Importamos el ThemeBloc y eventos
import 'package:pr_alpr_upc/src/bloc/theme_bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  await dotenv.load(fileName: ".env");

  // Verificamos si Firebase ya está inicializado
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(name: 'dev project',options: DefaultFirebaseOptions.currentPlatform);
  }

  // Inicializamos AuthStateManager después de Firebase
  await AuthStateManager.initializeAuthState();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<UserService>(create: (_) => UserService()),
        Provider<VehicleService>(create: (_) => VehicleService()),
        ProxyProvider<AuthService, AuthRepository>(
          update: (_, authService, __) => AuthRepository(authService: authService),
        ),
        ProxyProvider<UserService, UserRepository>(
          update: (_, userService, __) => UserRepository(userService: userService),
        ),
        ProxyProvider<VehicleService, VehicleRepository>(
          update: (_, vehicleService, __) => VehicleRepository(vehicleService: vehicleService),
        ),
      ],
      child: Builder(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  AuthBloc(authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider(
              create: (_) =>
                  UserBloc(userRepository: context.read<UserRepository>()),
            ),
            BlocProvider(
              create: (_) =>
                  VehicleBloc(vehicleRepository: context.read<VehicleRepository>()),
            ),
            // Agregamos el ThemeBloc
            BlocProvider(
              create: (_) => ThemeBloc(themeRepository: ThemeRepository())..add(LoadTheme()),
            ),
          ],
          // Usamos BlocBuilder para reconstruir el MaterialApp cuando cambie el tema
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                title: 'Material App',
                initialRoute: 'login',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeState.themeMode,
                debugShowCheckedModeBanner: false,
                routes: {
                  'initial': (BuildContext context) => const InitialPage(),
                  'login': (BuildContext context) => const LoginPage(),
                  'alert': (BuildContext context) => const AlertPage(),
                  'home': (BuildContext context) => const HomePage(),
                  'notification': (BuildContext context) => const NotificationPage(),
                  'user_guide': (BuildContext context) => const UserGuidePage(),
                  'movements': (BuildContext context) => const MovementsPage(),
                  'user_profile': (BuildContext context) => const UserProfilePage(),
                  'about': (BuildContext context) => const AboutPage(),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
