import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/nutritional_management/api.dart';
import 'package:flutter_application_1/screens/nutritional_management/calendar.dart';
import 'package:flutter_application_1/screens/nutritional_management/chart.dart';
import 'package:flutter_application_1/screens/nutritional_management/dataModel.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<StatefulWidget> createState() => _ManagementState();
}

// 表で表示するラベルの名前
final labelNames = ["栄養素", "数値"];

class _ManagementState extends State<Management> {
  Nutrients? _nutrients; // APIから取得したデータを格納
  bool _isLoading = true; // データがロード中かどうかを示す

  // 表の列ラベルを生成
  final labels = List<DataColumn>.generate(
      2, (int index) => DataColumn(label: Text(labelNames[index])),
      growable: false); // カラム名（栄養素と数値）の配列を生成

  @override
  void initState() {
    super.initState();
    _fetchNutrientsData();
  }

  void _fetchNutrientsData() async {
    Nutrients? nutrients = await fetchNutrients(1);
    setState(() {
      _nutrients = nutrients;
      _isLoading = false; // データ取得完了
    });
  }

  // 取得した栄養データからDataRowのリストを生成
  List<DataRow> _buildRows() {
    if (_nutrients == null) {
      return [];
    }

    // Nutrientsオブジェクトからデータを抽出して行を生成
    return [
      DataRow(cells: [
        const DataCell(Text("タンパク質")),
        DataCell(Text("${_nutrients!.protein}グラム")),
      ]),
      DataRow(cells: [
        const DataCell(Text("炭水化物")),
        DataCell(Text("${_nutrients!.carbohydrate}グラム")),
      ]),
      DataRow(cells: [
        const DataCell(Text("脂質")),
        DataCell(Text("${_nutrients!.lipid}グラム")),
      ]),
    ];
  }

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
        width: MediaQuery.of(context).size.width,  // 画面全体の幅に合わせる
        height: MediaQuery.of(context).size.height, // 画面全体の高さに合わせる
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像
            fit: BoxFit.cover, // 画像を画面全体にカバー
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // APIデータをレーダーチャートに渡す
              _nutrients != null 
                ? RadarChartSample1(
                  protein: _nutrients!.protein,
                  carbohydrates: _nutrients!.carbohydrate,
                  lipid: _nutrients!.lipid,
                )
                : const CircularProgressIndicator(), // データがないときはローディングインジケーター
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(16), // 角を丸くする
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(20),
                child: _isLoading
                    ? const CircularProgressIndicator() // データがロード中のときはローディングインジケーターを表示
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // 横スクロールを有効に
                        child: DataTable(
                            columns: labels,
                            rows: _buildRows()), // DataTableで栄養素と数値を表示
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
