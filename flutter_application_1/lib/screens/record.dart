import 'package:flutter/material.dart';

class Record extends StatefulWidget {
  const Record({super.key});
  
  @override
  State<StatefulWidget> createState() => _RecordState();
}

class _RecordState extends State<Record> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
      ),
      body: Container( // 背景画像を全体のContainerに設定
        width: MediaQuery.of(context).size.width, // 画面全体の幅に合わせる
        height: MediaQuery.of(context).size.height, // 画面全体の高さに合わせる
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }

}