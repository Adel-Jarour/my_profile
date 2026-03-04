import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/routes/app_pages.dart';

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
          seedColor: ColorConst.primaryColor,
          primary: ColorConst.primaryColor,
          secondary: ColorConst.secondColor,
          surface: ColorConst.secondColor,
          onPrimary: Colors.white,
          onSecondary: ColorConst.thirdColor,
          onSurface: ColorConst.thirdColor,
        ),
        scaffoldBackgroundColor: ColorConst.secondColor,
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: ColorConst.thirdColor,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: ColorConst.thirdColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: ColorConst.thirdColor,
          ),
        ),
      ),
    );
  }
}
