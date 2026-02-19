import 'dart:async';
import 'package:flutter/material.dart';

import 'package:uijaffazapp/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
late AnimationController _controller;

@override
void initState() {
  super.initState();

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  _controller.forward(); 

  Timer(const Duration(seconds: 3), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  });
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Code Wire',
          style: TextStyle(
            fontSize: 45,
          ),
        ),
      ),
    );
  }
}

    