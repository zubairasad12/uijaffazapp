import 'package:flutter/material.dart';
import 'package:uijaffazapp/colors/app_color.dart';

import 'package:uijaffazapp/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: AppColor.primaryColor,
      builder: (context, color, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: color,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(backgroundColor: color),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
