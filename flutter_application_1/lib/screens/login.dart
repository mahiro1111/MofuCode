import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // APIのURL (ngrokを使ったローカルホストのURL)
    const String apiUrl = "https://your-ngrok-url.com/login"; // APIのURL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // ログイン成功
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ログイン成功: ${responseData['message']}')),
        );
        // 必要に応じて次の画面に遷移する
      } else {
        // ログイン失敗
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ログイン失敗: ${responseData['error']}')),
        );
      }
    } catch (e) {
      // エラーハンドリング
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FFd8),
        title: Center(
          child:const Text('ログイン'),
        )
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
            fit: BoxFit.cover, // 画像を画面全体に広げる
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // メール入力フィールド
            TextField(
              controller: _emailController, // コントローラを追加
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
              controller: _passwordController, // コントローラを追加
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
            // ログインボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login, // ボタンが押されたときの処理
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9FACA), // ボタンの背景色
                  foregroundColor: const Color(0xFF4b4b4b), // ボタンのテキストカラー
                ),
                child: const Text('ログイン'),
              ),
            ),
            GestureDetector(
              onTap: () {
                // タップ時の画面遷移処理
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: Text(
                '新規登録はこちら',
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

