import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Cook.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _showTextField = false; // 入力欄を表示するかどうかのフラグ
  final TextEditingController _textController = TextEditingController(); // 料理名を入力するためのコントローラー

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const CharacterImage = 'images/abatar.png';

    final comment = Container(
      margin: const EdgeInsets.only(left: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const Text(
        '''何食べたの～？''',
        style: TextStyle(color: Colors.white),
      ),
    );

    final TalkCharacter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          CharacterImage,
          width: 200,
          height: 200,
        ),
        comment,
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('食事管理')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
            fit: BoxFit.cover, // 画像を画面全体に広げる
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showTextField = !_showTextField; // ボタン押下で入力欄の表示を切り替え
                });
              },
              child: _showTextField
                  ? const Text('入力をキャンセル')
                  : const Text('料理名を入力'),
            ),
            if (_showTextField) // 入力欄を表示するかどうか
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: '料理名',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                // 料理名を表示する画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CookScreen(),
                  ),
                );
              },
              child: const Text('料理名を決定'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context)=>const CookScreen()),
                );
              }, 
              child: const Text('まだ食べてない…')
            ),
            TalkCharacter,
          ],
        ),
      ),
    );
  }
}
