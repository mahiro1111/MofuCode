import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/nutritional_management/calendar.dart';
import 'package:flutter_application_1/screens/nutritional_management/chart.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<StatefulWidget> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  final labels = List<DataColumn>.generate(
      3, (int index) => DataColumn(label: Text("ラベル$index")),
      growable: false);

  final values = List<DataRow>.generate(10, (int index) {
    return DataRow(cells: [
      DataCell(Text("山田$index郎")),
      const DataCell(Text("男性")),
      const DataCell(Text("2000/10/30")),
    ]);
  }, growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('栄養管理'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const Calendar();
                  });
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadarChartSample1(),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // 横スクロールを有効に
                child: DataTable(columns: labels, rows: values),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _table(List<DataColumn> columnList, List<DataRow> rowList) {
    // ListViewで縦スクロール, SingleChildScrollViewで横スクロール設定している
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: columnList, rows: rowList),
        )
      ],
    );
  }
}
