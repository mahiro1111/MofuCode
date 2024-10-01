import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/nutritional_management/calendar.dart';
import 'package:flutter_application_1/screens/nutritional_management/chart.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<StatefulWidget> createState() => _ManagementState();
}

// 表で表示するラベルの名前
final nutrients = ["タンパク質", "炭水化物", "脂質"];
final labelNames = ["栄養素", "数値"];

class _ManagementState extends State<Management> {
  // 表の列ラベルを生成
  final labels = List<DataColumn>.generate(
      2, (int index) => DataColumn(label: Text(labelNames[index])),
      growable: false); // カラム名（栄養素と数値）の配列を生成

  // 表の各行データを生成
  final values = List<DataRow>.generate(3, (int index) {
    return DataRow(cells: [
      DataCell(Text(nutrients[index])),
      DataCell(Text("${(index + 1) * 100}グラム")),
    ]);
  }, growable: false); // 栄養素のリストと量を対応付けて行を生成

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('栄養管理'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month), // カレンダーアイコン
            onPressed: () {
              // カレンダーを表示するためのモーダルを開く
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const Calendar(); // カレンダーウィジェットを表示
                  });
            },
          ),
        ],
      ),
      // 背景画像を全体のContainerに設定
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像
            fit: BoxFit.cover, // 画像を画面全体にカバー
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RadarChartSample1(), // レーダーチャートウィジェットを表示
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(16), // 角を丸くする
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 横スクロールを有効に
                  child: DataTable(
                      columns: labels, rows: values), // DataTableで栄養素と数値を表示
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
