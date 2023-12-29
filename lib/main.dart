import 'package:auth_state_manager/auth_state_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pr_alpr_upc/src/providers/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/firebase_options.dart';
import 'package:pr_alpr_upc/src/pages/alert_page.dart';
import 'package:pr_alpr_upc/src/pages/home_page.dart';
import 'package:pr_alpr_upc/src/pages/login_page.dart';
import 'package:pr_alpr_upc/src/pages/initial_page.dart';
import 'package:pr_alpr_upc/src/pages/notification_page.dart';
import 'package:pr_alpr_upc/src/services/locar_storage.dart';
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
            return authState.isLoggedIn ? HomePage() : const LoginPage();
          },
          'alert': (BuildContext context) => const AlertPage(),
          'home': (BuildContext context) => HomePage(),
          'notification': (BuildContext context) => const NotificationPage()
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
