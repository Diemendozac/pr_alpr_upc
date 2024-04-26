import 'package:auth_state_manager/auth_state_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pr_alpr_upc/src/pages/about_page/about_page.dart';
import 'package:pr_alpr_upc/src/pages/movements_page/movements_page.dart';
import 'package:pr_alpr_upc/src/pages/user_guide_page/user_guide_page.dart';
import 'package:pr_alpr_upc/src/pages/user_profile_page/user_profile_page.dart';
import 'package:pr_alpr_upc/src/providers/auth_state.dart';
import 'package:pr_alpr_upc/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/config/firebase_options.dart';
import 'package:pr_alpr_upc/src/pages/alert/alert_page.dart';
import 'package:pr_alpr_upc/src/pages/home_page/home_page.dart';
import 'package:pr_alpr_upc/src/pages/login_page/login_page.dart';
import 'package:pr_alpr_upc/src/pages/initial_page/initial_page.dart';
import 'package:pr_alpr_upc/src/pages/notification_page/notification_page.dart';
import 'package:pr_alpr_upc/src/services/local_storage.dart';
import 'package:pr_alpr_upc/src/theme/theme_constans.dart';
import 'package:pr_alpr_upc/src/theme/theme_manager.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  await AuthStateManager.initializeAuthState();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager.instance;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthState(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider.instance,
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'login',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: getTheme(),
        debugShowCheckedModeBanner: false,
        routes: {
          'initial': (BuildContext context) => const InitialPage(),
          'login': (BuildContext context) {
            final authState = context.watch<AuthState>();
            return authState.isLoggedIn ? const HomePage() : const LoginPage();
          },
          'alert': (BuildContext context) => const AlertPage(),
          'home': (BuildContext context) => const HomePage(),
          'notification': (BuildContext context) => const NotificationPage(),
          'user_guide': (BuildContext context) => const UserGuidePage(),
          'movements': (BuildContext context) => const MovementsPage(),
          'user_profile': (BuildContext context) => const UserProfilePage(),
          'about': (BuildContext context) => const AboutPage(),
        },
      ),
    );
  }

  ThemeMode getTheme() {
    if (LocalStorage.prefs.getBool("themeMode") == null) LocalStorage.prefs.setBool("themeMode", true);
    return LocalStorage.prefs.getBool("themeMode")!
        ? ThemeMode.light
        : ThemeMode.dark;
  }
}
