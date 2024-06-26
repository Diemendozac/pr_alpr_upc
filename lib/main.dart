import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/firebase_options.dart';
import 'package:pr_alpr_upc/src/pages/alert_page.dart';
import 'package:pr_alpr_upc/src/pages/login_page.dart';
import 'package:pr_alpr_upc/src/pages/initial_page.dart';
import 'package:pr_alpr_upc/src/theme/theme_constans.dart';
import 'package:pr_alpr_upc/src/theme/theme_manager.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());

}

ThemeManager _themeManager = ThemeManager.instance;

class MyApp extends StatefulWidget {
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
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'initial',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      debugShowCheckedModeBanner: false,
      routes: {
        'initial': (BuildContext context) => const InitialPage(),
        'login': (BuildContext context) => const LoginPage(),
        'alert': (BuildContext context) => AlertPage(),

      },
    );
  }
}
