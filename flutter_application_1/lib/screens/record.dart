import 'package:flutter/material.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<StatefulWidget> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  var _choiceIndex = 0;

  // コントローラでテキストフィールドの値を取得
  final TextEditingController _foodItemController = TextEditingController();
  //final TextEditingController _mealTimeController = TextEditingController();

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
              _choiceIndex = 0; // 画面全体をタップしたときに選択解除
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
                // 食事時間入力フィールド
                // TextField(
                //   controller: _mealTimeController, // コントローラを追加
                //   keyboardType: TextInputType.number, //数値のキーボードを表示
                //   inputFormatters: [FilteringTextInputFormatter.digitsOnly], //入力できる文字を数値のみに制限
                //   decoration: const InputDecoration(
                //     prefixIcon: Icon(Icons.schedule),
                //     labelText: '食事時間',
                //     border: OutlineInputBorder(),
                //     filled: true,
                //     fillColor: Color(0xFFF7FFd8),
                //   ),
                // ),
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
                  margin: const EdgeInsets.only(right: 35),
                  child: Image.asset(
                    'images/abatar.png',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
