import 'package:demo_apps/apps/screen/MainScreen.dart';
// import 'package:demo_application/screen/first_screen.dart';
import 'package:flutter/material.dart';

class AppLogic extends StatelessWidget {
  const AppLogic({super.key});

  @override
  Widget build(BuildContext context) {
    // Color seedColor = Color(0xFF2E6F40);
    // Color primary = seedColor;
    // Color secondary = Color(0xFFCFFFDC);
    // Color bgNavBarColor = Color(0xFF68BA7F);

    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const MainScreen(),
    );
  }
}
