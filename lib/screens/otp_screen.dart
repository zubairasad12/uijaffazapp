// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uijaffazapp/homepage.dart';
import 'dart:convert';
import 'package:uijaffazapp/screens/login.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  bool isLoading = false;
Future<void> verifyOtp(String otp) async {
  try {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/reset-password/$otp"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.body}")),
      );
    }

  } catch (e) {
    print("CATCH ERROR: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Catch Error: $e")),
    );
  }
}

    

  void checkOtp() {
    String otp = controllers.map((c) => c.text).join();

    if (otp.length == 4) {
      verifyOtp(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Enter 4 digit code",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: 55,
                      height: 60,
                      child: TextField(
                        controller: controllers[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                          checkOtp(); // 🔥 Auto check
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                if (isLoading)
                  const CircularProgressIndicator(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
