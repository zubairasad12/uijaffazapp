// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uijaffazapp/screens/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  bool loading = false;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  Future<void> registerUser() async {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept terms & privacy policy")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final response = await http.post(
        Uri.parse("https:http://127.0.0.1:8000/api/register"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": nameCtrl.text,
          "email": emailCtrl.text,
          "password": passCtrl.text,
          "password_confirmation": passCtrl.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(" Register Successful")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Registration failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withOpacity(0.1)),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/chef.png', height: 140),
                    const SizedBox(height: 10),

                    
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  "log in",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _inputField("Full Name", "Full Name", controller: nameCtrl),
                    const SizedBox(height: 14),
                    _inputField("Email Address", "Email Address", controller: emailCtrl),
                    const SizedBox(height: 14),
                    _inputField(
                      "Password",
                      "Password",
                      isPassword: true,
                      controller: passCtrl,
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() => isChecked = value!);
                          },
                        ),
                        const Expanded(
                          child: Text("I agree to Terms and Privacy Policy"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 199, 89, 55),
                            Color(0xFFFF7043),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: loading ? null : registerUser,
                        child: Center(
                          child: loading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(
    String label,
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
