import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RadarChartSample1 extends StatefulWidget {
  RadarChartSample1({super.key});

  // グリッド、タイトル、ラインの色をプロパティとして定義
  final gridColor = Colors.white70;
  final textColor = Colors.yellow[50];
  final lineColor = Colors.green;

  @override
  State<RadarChartSample1> createState() => _RadarChartSample1State();
}

class _RadarChartSample1State extends State<RadarChartSample1> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 横方向では左揃え
        mainAxisAlignment: MainAxisAlignment.center, // 縦方向では中央揃え
        children: [
          // タイトルテキスト
          Text(
              '今日の栄養素',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: widget.textColor,
              ),
            ),
          const SizedBox(height: 4), // 4ピクセルの垂直方向の余白
          AspectRatio(
            aspectRatio: 0.9, // 幅と高さの比率
            child: RadarChart(
              RadarChartData(
                dataSets: showingDataSets(),
                radarBorderData: BorderSide(color: widget.gridColor),
                
                titlePositionPercentageOffset: 0.1,
                titleTextStyle:
                    TextStyle(
                      color: widget.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      ),
                // インデックスごとにタイトルを設定
                getTitle: (index, angle) {
                  switch (index) {
                    case 0:
                      return const RadarChartTitle(text: 'タンパク質');
                    case 2:
                      return const RadarChartTitle(text: '脂質');
                    case 1:
                      return const RadarChartTitle(text: '糖質');
                    default:
                      return const RadarChartTitle(text: '');
                  }
                },
                tickCount: 2, // チャート内の目盛り数
                ticksTextStyle: const TextStyle(color: Colors.transparent),
                tickBorderData: BorderSide(color: widget.gridColor),
                gridBorderData: BorderSide(color: widget.gridColor, width: 2),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }

  // レーダーチャートに表示するデータセットを定義
  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final rawDataSet = entry.value;

      // データセットをレーダーチャートに追加
      return RadarDataSet(
        fillColor: rawDataSet.color.withOpacity(0.5),
        borderColor: rawDataSet.color,
        entryRadius: 3,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: 2,
      );
    }).toList();
  }

  // データセットの元データを返す関数
  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        color: widget.lineColor,
        values: [
          300,
          50,
          250,
        ],
      ),
    ];
  }
}

// データセットを表すクラス
class RawDataSet {
  RawDataSet({
    required this.color,
    required this.values,
  });

  final Color color;
  final List<double> values;
}