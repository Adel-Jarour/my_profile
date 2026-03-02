import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Profile',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFfa824c), // primary
          primary: const Color(0xFFfa824c),
          secondary: const Color(0xFFebeae6),
          surface: const Color(0xFFebeae6),
          onPrimary: Colors.white,
          onSecondary: const Color(0xFF323639),
          onSurface: const Color(0xFF323639),
        ),
        scaffoldBackgroundColor: const Color(0xFFebeae6), // second color
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF323639), // third color
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF323639),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF323639),
          ),
        ),
      ),
    );
  }
}
