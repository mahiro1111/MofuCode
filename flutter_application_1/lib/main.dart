import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Circle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CircleScreen(),
    );
  }
}

class CircleScreen extends StatelessWidget {
  const CircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Circle'),
      ),
      body: Center(
        child: Container(
          width: 100.0,  // 丸の直径
          height: 100.0, // 丸の直径
          decoration: BoxDecoration(
            color: Colors.red,  // 丸の色
            shape: BoxShape.circle,  // 丸の形状
          ),
        ),
      ),
    );
  }
}
