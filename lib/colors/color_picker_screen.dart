import 'package:flutter/material.dart';
import 'app_color.dart';

class ColorPickerScreen extends StatelessWidget {
  ColorPickerScreen({super.key});

  final List<Color> colors = [
    Colors.deepOrange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Color")),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Wrap(
                  spacing: 20,
                  children: colors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        AppColor.changeColor(color); // 🔥 magic line
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: color,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
