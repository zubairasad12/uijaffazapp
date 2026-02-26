// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uijaffazapp/colors/color_picker_screen.dart';
import 'package:uijaffazapp/homepage.dart';
import 'package:uijaffazapp/screens/forget_screen.dart';
import 'package:uijaffazapp/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool check = false;
  
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool loading = false;
  bool rememberMe = false;
Future<void> loginUser() async {
  setState(() => loading = true);

  try {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/login"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": emailCtrl.text,
        "password": passCtrl.text,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      // ✅ TOKEN SAVE KARO
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(" Login Successful")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );

    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? "Invalid credentials")),
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
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      
            child: Container(color: Colors.white.withOpacity(0.1)),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                 
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ColorPickerScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  "Log In",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _inputField(
                      "Email",
                      "Alex.David@gmail.com",
                      controller: emailCtrl,
                    ),
                    const SizedBox(height: 14),
                    _inputField(
                      "Password",
                      "••••••••",
                      isPassword: true,
                      controller: passCtrl,
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (v) => setState(() => rememberMe = v ?? false),
                        ),
                        const Text("Remember Me"),
                        const Spacer(),
                       
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgetScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                        
                      ],
                    ),

                    const SizedBox(height: 16),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF5722), Color(0xFFFF7043)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: loading ? null : loginUser,
                        child: Center(
                          child: loading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text("Or"),
                    const SizedBox(height: 16),
                    _socialButton(
                      icon: Icons.apple,
                      text: "Continue With Apple",
                    ),
                    const SizedBox(height: 12),
                    _socialButton(
                      icon: Icons.g_mobiledata,
                      text: "Continue With Google",
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
            suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialButton({required IconData icon, required String text}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), const SizedBox(width: 10), Text(text)],
      ),
    );
  }
}
