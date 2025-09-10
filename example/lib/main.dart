import 'package:flutter/material.dart';
import 'package:ultra_fine/ultra_fine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Animated Text Example")),
        body: Center(
          child: AnimatedTextUltra(
            text: "Hello from my package!",
            style: const TextStyle(fontSize: 28, color: Colors.blue),
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }
}
