import 'package:donative_scanner/screens/home_page.dart';
import 'package:donative_scanner/screens/report_preview.dart';
import 'package:flutter/material.dart';
import 'package:donative_scanner/screens/start_page.dart';
import 'package:donative_scanner/utils/color_constants.dart';
import 'models/report.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManagement.getTheme(),
      initialRoute: '/',
      routes: RouteManagement.getRoutes(),
    );
  }
}

class RouteManagement {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/': (context) => const StartPage(),
      '/homePage': (context) => const HomePage(),
    };
  }
}

class ThemeManagement {
  static ThemeData getTheme() {
    return ThemeData(
        fontFamily: 'Lato',
        primaryColor: lightTeal,
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 48.0,
                color: green,
                fontWeight: FontWeight.w800,
                letterSpacing: 5),
            titleLarge: TextStyle(
                fontSize: 21.0,
                color: teal,
                fontWeight: FontWeight.w800,
                letterSpacing: 5),
            titleSmall: TextStyle(
                fontSize: 20.0, color: lightGreen, fontWeight: FontWeight.w100),
            bodyMedium: TextStyle(
                fontSize: 20.0, color: black, fontWeight: FontWeight.normal),
            bodySmall: TextStyle(
              fontSize: 18.0,
              color: black,
              fontWeight: FontWeight.normal,
            ),
            labelLarge: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                color: white,
                letterSpacing: 1),
            labelMedium: TextStyle(
              fontSize: 18.0,
              color: white,
              fontWeight: FontWeight.normal,
            ),
            labelSmall: TextStyle(
              fontSize: 15.0,
              color: white,
              fontWeight: FontWeight.normal,
            )));
  }
}
