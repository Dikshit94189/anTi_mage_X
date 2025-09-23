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
        appBar: AppBar(title: const Text("Animated Text")),
        body: Center(
          child: AnimatedTextUltra(
            showText: true,
            texts: [
              "Hello from my package!",
              "Animated Text 😎",
              "Made By Dikshit",
            ],
            style: const TextStyle(fontSize: 28, color: Colors.blue),
            duration: const Duration(seconds: 5),
            loop: true, // keeps repeating
            containerC: Colors.teal,
            buttonName: "Name",
            icon: Icon(Icons.favorite,size: 40, color: Colors.red), // <-- customized icon
            iconColors: Colors.black,
            onTap: (){
              print("object");
            },
          ),
        ),
      ),
    );
  }
}
