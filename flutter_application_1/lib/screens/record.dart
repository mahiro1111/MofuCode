import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<StatefulWidget> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  var _choiceIndex = 0;

  // コントローラでテキストフィールドの値を取得
  final TextEditingController _mealTypeController = TextEditingController();
  final TextEditingController _foodItemController = TextEditingController();

  // APIにデータを送信する関数
  Future<void> _record() async {
    final String mealType = _mealTypeController.text;
    final String foodItem = _foodItemController.text;

    // APIのURL
    const apiUrl = 'https://460e-133-203-160-33.ngrok-free.app/meals';

    try {
      // リクエストボディを作成
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "meal_type": mealType,
          "food_items": foodItem,
        }),
      );

      // ステータスコードを確認してレスポンスを処理
      if (response.statusCode == 201) {
        // 登録成功
        final responseData = jsonDecode(response.body);
        String token = responseData['token'];

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
          title: const Text('記録'),
        ),
        body: GestureDetector(
          // 画面全体をタップ可能にするためのGestureDetector
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();
            });
          },
          child: Container(
            // 背景画像を全体のContainerに設定
            width: MediaQuery.of(context).size.width, // 画面全体の幅に合わせる
            height: MediaQuery.of(context).size.height, // 画面全体の高さに合わせる
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background_sample.jpg'),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                // ボタン行を表示
                Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // ボタンを均等に配置
                    children: [
                      ChoiceChip(
                        label: const Text("朝食"),
                        selected: _choiceIndex == 1,
                        backgroundColor: Colors.grey[400],
                        selectedColor: Colors.white,
                        onSelected: (_) {
                          setState(() {
                            _choiceIndex = 1;
                            _mealTypeController.text = "breakfast"; // 選択した値をコントローラーに設定
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text("昼食"),
                        selected: _choiceIndex == 2,
                        backgroundColor: Colors.grey[400],
                        selectedColor: Colors.white,
                        onSelected: (_) {
                          setState(() {
                            _choiceIndex = 2;
                            _mealTypeController.text = "lunch"; // 選択した値をコントローラーに設定
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text("夕食"),
                        selected: _choiceIndex == 3,
                        backgroundColor: Colors.grey[400],
                        selectedColor: Colors.white,
                        onSelected: (_) {
                          setState(() {
                            _choiceIndex = 3;
                            _mealTypeController.text = "dinner"; // 選択した値をコントローラーに設定
                          });
                        },
                      ),
                    ]),
                const SizedBox(height: 30),
                // 料理入力フィールド
                TextField(
                  controller: _foodItemController, // コントローラを追加
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.restaurant),
                    labelText: '料理名',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF7FFd8),
                  ),
                ),
                const SizedBox(height: 30),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20), // 全体の角丸を設定
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '今日は何を食べたかな？',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16), // フォントサイズ
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0, // テキストの下に表示
                      left: 0, // テキストの左側に表示
                      child: Transform.translate(
                        offset: const Offset(20, 0), // 最初の丸の位置を調整
                        child: const CircleAvatar(
                          radius: 10, // 丸のサイズ
                          backgroundColor: Colors.black, // 丸の色
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, // テキストの下に表示
                      left: 0, // テキストの左側に表示
                      child: Transform.translate(
                        offset: const Offset(35, 20), // 二つ目の丸の位置を調整
                        child: const CircleAvatar(
                          radius: 8, // 丸のサイズ
                          backgroundColor: Colors.black, // 丸の色
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'images/abatar.png',
                  ),
                ),
                // 登録ボタン
                SizedBox(
                  width: double.infinity, // ボタンが横幅いっぱいになる
                  child: ElevatedButton(
                    onPressed: _record, // ボタン押下時にサインアップ処理を呼び出す
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9FACA), // ボタンの背景色
                      foregroundColor: const Color(0xFF4b4b4b), // ボタンのテキストカラー
                    ),
                    child: const Text('記録する'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
