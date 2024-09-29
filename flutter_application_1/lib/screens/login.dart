//ログイン
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MofuCode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FFd8),
        title: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
          const Spacer(), 
          const Text('ログイン'),
          const Spacer(), 
          ],
        ),
      ),
      backgroundColor: Color(0xFF7ed5ff), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // メール入力フィールド
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.mail,
                ),
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),
            const SizedBox(height: 16),
            // パスワード入力フィールド
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.key,
                ),
                labelText: 'Password',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),
            const SizedBox(height: 24),
            // 登録ボタン
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                onPressed: () {
                  // ボタンが押されたときの処理
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF9FACA), // ボタンの背景色
                  foregroundColor: Color(0xFF4b4b4b),  // ボタンのテキストカラー
                ),
                child: const Text('login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
