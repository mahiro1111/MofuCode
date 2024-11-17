import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String _csrfToken = ''; // CSRFトークンを保存する変数

  @override
  void initState() {
    super.initState();
    fetchCsrfToken(); // アプリ起動時にCSRFトークンを取得
  }

  Future<void> fetchCsrfToken() async {
    try {
      final response =
        await http.get(Uri.parse('https://localhost:3000/csrf_token'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        _csrfToken = responseData['csrf_token']; // トークンを変数に格納
      });
    } else {
      print('CSRFトークンの取得に失敗しました: ${response.statusCode}, ${response.body}');
      throw Exception('CSRFトークンの取得に失敗しました: ${response.statusCode}');
    }
    } catch (e) {
      throw Exception('エラーが発生しました: $e');
    }
  }

 Future<void> _signup() async {
  // Input validation
  if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('すべてのフィールドを埋めてください')),
    );
    return;
  }

  // Parse values
  int age;
  double weight;
  double height;

  try {
    age = int.parse(_ageController.text);
    weight = double.parse(_weightController.text);
    height = double.parse(_heightController.text);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('年齢、体重、身長は数値である必要があります')),
    );
    return;
  }

  // APIのURL
  const apiUrl = 'http://localhost:3000/users';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": _csrfToken,
      },
      body: jsonEncode({
        "username": _nameController.text,
        "email": _emailController.text,
        "password_digest": _passwordController.text,
        "age": age,
        "weight": weight,
        "height": height,
        "gender": isSelectedValue,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登録成功: ${responseData['message']}')),
      );
    } else {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登録失敗: ${responseData['error']}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('エラーが発生しました: $e')),
    );
  }
}

  bool _isObscure = true;
  String? isSelectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: const Color(0xFFF7FFd8),
              title: Container(
                margin: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                child: const Text('新規登録'),
              )),
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
                // 名前入力フィールド
                TextField(
                  controller: _nameController, // コントローラを追加
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    labelText: '名前',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 16),
                // メール入力フィールド
                TextField(
                  controller: _emailController, // コントローラを追加
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@_\-.]')),
                  ], //入力できる文字を数値のみに制限
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Eメール',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 16),
                // パスワード入力フィールド
                TextField(
                  controller: _passwordController, // コントローラを追加
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key),
                    labelText: 'パスワード',
                    suffixIcon: IconButton(
                      // 文字の表示・非表示でアイコンを変える
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility),
                      // アイコンがタップされたら現在と反対の状態をセットする
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 16),
                // 年齢入力フィールド
                TextField(
                  controller: _ageController, // コントローラを追加
                  keyboardType: TextInputType.number, //数値のキーボードを表示
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], //入力できる文字を数値のみに制限
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: '年齢',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 16),
                // 身長入力フィールド
                TextField(
                  controller: _heightController, // コントローラを追加
                  keyboardType: TextInputType.number, //数値のキーボードを表示
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ], //入力できる文字を数値と.のみに制限
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.height),
                    labelText: '身長',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 16),
                // 体重入力フィールド
                TextField(
                  controller: _weightController, // コントローラを追加
                  keyboardType: TextInputType.number, //数値のキーボードを表示
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ], //入力できる文字を数値と.のみに制限
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.monitor_weight),
                    labelText: '体重',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 16),
                // 性別選択
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF7FFd8),
                      border: Border.all(
                        color: Colors.black, // 枠線の色
                        width: 0.7, // 枠線の太さ
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: <Widget>[
                    const SizedBox(width: 12),
                    const Icon(Icons.wc),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 300,
                      child: DropdownButton<String>(
                        hint: const Text('性別'),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('男')),
                          DropdownMenuItem(value: 'female', child: Text('女')),
                        ],
                        value: isSelectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            isSelectedValue = value; // 選択された値で状態を更新
                            _genderController.text = value!; // 選択した値をコントローラーに設定
                          });
                        },
                        menuWidth: 347,
                        borderRadius: BorderRadius.circular(5),
                        underline: Container(),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 24),
                // 登録ボタン
                SizedBox(
                  width: double.infinity, // ボタンが横幅いっぱいになる
                  child: ElevatedButton(
                    onPressed: _signup, // ボタン押下時にサインアップ処理を呼び出す
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9FACA), // ボタンの背景色
                      foregroundColor: const Color(0xFF4b4b4b), // ボタンのテキストカラー
                    ),
                    child: const Text('新規登録'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
