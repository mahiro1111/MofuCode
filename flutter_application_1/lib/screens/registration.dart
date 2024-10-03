import 'package:flutter/material.dart';
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
      title: 'MofuCode_registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // コントローラでテキストフィールドの値を取得
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  // APIにデータを送信する関数
  Future<void> _signup() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final int age = int.parse(_ageController.text);
    final double weight = double.parse(_weightController.text);
    final double height = double.parse(_heightController.text);
    final String gender = _genderController.text;

    // APIのURL (例としてngrokを使ったローカルホストのURL)
    const String apiUrl = "https://your-ngrok-url.com/users";  // APIのURL

    try {
      // リクエストボディを作成
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": name,
          "email": email,
          "password": password,
          "age": age,
          "weight": weight,
          "height": height,
          "gender": gender,
        }),
      );

      // ステータスコードを確認してレスポンスを処理
      if (response.statusCode == 201) {
        // 登録成功
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登録成功: ${responseData['message']}')),
        );
      } else {
        // 登録失敗
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登録失敗: ${responseData['error']}')),
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
        title:Container(
          margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: const Text('新規登録'),
        ) 
      ),
      
      body: Center(
        child:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
              fit: BoxFit.cover,  // 画像を画面全体に広げる
            ),
          ),
          //padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // 名前入力フィールド
              TextField(
                controller: _nameController,  // コントローラを追加
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF7FFd8),
                ),
              ),
              const SizedBox(height: 16),
              // メール入力フィールド
              TextField(
                controller: _emailController,  // コントローラを追加
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF7FFd8),
                ),
              ),
              const SizedBox(height: 16),
              // パスワード入力フィールド
              TextField(
                controller: _passwordController,  // コントローラを追加
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF7FFd8),
                ),
              ),
              const SizedBox(height: 16),
              // 年齢入力フィールド
              TextField(
                controller: _ageController,  // コントローラを追加
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF7FFd8),
                ),
              ),
              const SizedBox(height: 16),
              // 体重入力フィールド
              TextField(
                controller: _weightController,  // コントローラを追加
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.monitor_weight),
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF7FFd8),
                ),
              ),
              const SizedBox(height: 16),
              // 身長入力フィールド
              TextField(
                controller: _heightController,  // コントローラを追加
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.height),
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF7FFd8),
                ),
              ),
              const SizedBox(height: 16),
              // 性別入力フィールド
              TextField(
                controller: _genderController,  // コントローラを追加
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.wc),
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
                  onPressed: _signup,  // ボタン押下時にサインアップ処理を呼び出す
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9FACA), // ボタンの背景色
                    foregroundColor: const Color(0xFF4b4b4b),  // ボタンのテキストカラー
                  ),
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
