//新規登録
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MofuCode_registration',
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
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30),
              onPressed: () {
                Navigator.pop(context);  // これで前の画面に戻れます
              },
            ),
            const Spacer(),
            const Text('新規登録'),
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
            // 名前入力フィールド
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                ),
                labelText: 'Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),
            const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
            // 年齢入力フィールド
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Age',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),
            const SizedBox(height: 16),
            // 体重入力フィールド
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.monitor_weight,
                ),
                labelText: 'Weight',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),
            const SizedBox(height: 16),
            // 身長入力フィールド
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.height,
                ),
                labelText: 'Height',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),
            const SizedBox(height: 16),
            // 性別入力フィールド
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.wc,
                ),
                labelText: 'Gender',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF7FFd8),
              ),
            ),

            const SizedBox(height: 24),
            // 登録ボタン
            SizedBox(
              width: double.infinity, // ボタンが横幅いっぱいになる
              child: ElevatedButton(
                onPressed: () {
                  // ボタンが押されたときの処理
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF9FACA), // ボタンの背景色
                  foregroundColor: Color(0xFF4b4b4b),  // ボタンのテキストカラー
                ),
                child: const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
