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
      title: 'MofuCode_login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FFd8),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30),
              onPressed: () {
                Navigator.pop(context);  // これで前の画面に戻れます
              },
            ),
            const Spacer(),
            const Text('ログイン'),
            const Spacer(),
          ],
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
            fit: BoxFit.cover,  // 画像を画面全体に広げる
          ),
        ),

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
