import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Layout Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ButtonScreen(),
    );
  }
}

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('食材入力'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(top: 20.0), // 画面の上にスペースを確保
        child: Column(
          children: [
            // ボタン行を表示
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタンを均等に配置
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 朝のボタンが押されたときの処理
                  },
                  child: const Text('朝食'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 昼のボタンが押されたときの処理
                  },
                  child: const Text('昼食'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 夜のボタンが押されたときの処理
                  },
                  child: const Text('夜食'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 間食のボタンが押されたときの処理
                  },
                  child: const Text('間食'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
              const SizedBox(height: 20), 
            // 動的にTextFormFieldを表示する部分
            const Expanded(
              child: Sample(), // ここにSampleクラスを挿入
            ),
          ],
        ),
      ),
    );
  }
}

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  List<TextEditingController> _textEditingControllers = [];

  @override
  void initState() {
    _textEditingControllers.add(TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _textEditingControllers.length,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _textFormFieldWithButton(
                      textEditingController: _textEditingControllers[index],
                      onPressed: () {
                        // このボタンで新しいテキストフィールドを追加する
                        setState(() {
                          _textEditingControllers.add(TextEditingController());
                        });
                      },
                    ),
                    const SizedBox(height: 20.0)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _textFormFieldWithButton({
  required TextEditingController textEditingController,
  required void Function() onPressed,
}) {
  return Row(
    children: [
      Expanded(
        // テキストフィールドを可能な限り広げる
        child: TextFormField(
          controller: textEditingController,
          maxLength: null,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            fillColor: Color(0xFFF7FFd8),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)), // 角を丸くする
              borderSide: BorderSide(
                color: Color(0xFFF7FFd8),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF7FFd8),
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10.0), // テキストフィールドとボタンの間にスペース
      _textButton(
        onPressed: onPressed,
      ),
    ],
  );
}

Widget _textButton({required void Function() onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: const Text("＋"),
  );
}
