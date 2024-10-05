import 'package:flutter/material.dart';
import 'dart:convert';  // JSONエンコードとデコードのために必要
import 'package:http/http.dart' as http;  // httpリクエスト用のパッケージ
import 'package:intl/intl.dart'; // 日付を扱うためのパッケージ
import 'package:shared_preferences/shared_preferences.dart'; // データをローカルに保存するためのパッケージ

void main() {
  runApp(const Home());
}

class MealService {
  static const String apiUrl = 'http://your-api-url.com/api/meals'; // APIのURL

  Future<Map<String, dynamic>> createMeal(String foodItems, String mealType) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your-auth-token', // トークンを適切に設定
      },
      body: jsonEncode({
        'meal': {
          'food_items': foodItems,
          'meal_type': mealType,
        }
      }),
    );

    if (response.statusCode == 200) {
      // 成功時の処理: レスポンスデータを返す
      return jsonDecode(response.body);
    } else {
      // エラー時の処理
      throw Exception('Failed to create meal: ${response.body}');
    }
  }
}

class NutrientDeficiencyService {
  static const String apiUrl = 'http://your-api-url.com/api/nutrient_deficiency'; // APIのURL

  Future<Map<String, dynamic>> getNutrientDeficiency() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your-auth-token', // トークンを適切に設定
      },
    );

    if (response.statusCode == 200) {
      // 成功時の処理: レスポンスデータを返す
      return jsonDecode(response.body);
    } else {
      // エラー時の処理
      throw Exception('Failed to load nutrient deficiency data: ${response.body}');
    }
  }
}


// メイン画面
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hasNutrientData = false; // 栄養データが入力されているかどうかを管理
  bool isDeficient = true; // 栄養不足があるかどうかを管理
  int dayIndex = 0; // 曜日を管理する変数
  DateTime? lastResetDate; // 最後にリセットされた日付

  @override
  void initState() {
    super.initState();
    _loadNutrientDeficiencyData();
    _loadLastResetDate();
  }

    Future<void> _loadLastResetDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastResetDateString = prefs.getString('lastResetDate');
    if (lastResetDateString != null) {
      lastResetDate = DateTime.parse(lastResetDateString);
      if (DateTime.now().difference(lastResetDate!).inDays >= 7) {
        _resetIcons();
      } else {
        _updateDayIndex();
      }
    } else {
      _updateDayIndex();
    }
  }

  void _updateDayIndex() {
    String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
    setState(() {
      dayIndex = _getDayIndex(dayOfWeek);
    });
  }

  Future<void> _resetIcons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dayIndex = 0;
      lastResetDate = DateTime.now();
    });
    await prefs.setString('lastResetDate', lastResetDate!.toIso8601String());
  }

  int _getDayIndex(String dayOfWeek) {
    switch (dayOfWeek) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      case 'Sunday':
        return 6;
      default:
        return 9;
    }
  }

  Future<void> _loadNutrientDeficiencyData() async {
    // サーバーやデータベースからNutrientDeficiencyのデータを取得
    NutrientDeficiencyService service = NutrientDeficiencyService();
    Map<String, dynamic> nutrientData = await service.getNutrientDeficiency();

    if (nutrientData.isNotEmpty) {
      // データが存在する場合
      setState(() {
        hasNutrientData = true;
        // 栄養不足がない場合（全ての不足分が0）
        isDeficient = !(nutrientData['carbohydrates'] == 0 &&
                        nutrientData['proteins'] == 0 &&
                        nutrientData['fats'] == 0);
      });
    } else {
      // データが存在しない場合
      setState(() {
        hasNutrientData = false; // 栄養データがない
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NutriGrow'),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 90,
                  // 栄養データが存在しない場合は☆を表示、存在して不足がない場合は★を表示、不足がある場合は☆
                  //月曜日
                  child: dayIndex == 0 
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),
                Positioned(
                  top: 20,
                  left: 175,
                  //火曜日
                  child: dayIndex == 1 
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),
                Positioned(
                  top: 20,
                  left: 260,
                  //水曜日
                  child: dayIndex == 2 
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),
                Positioned(
                  top: 80,
                  left: 50,
                  //木曜日
                  child: dayIndex ==  3
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),
                Positioned(
                  top: 80,
                  left: 133,
                  //金曜日
                  child: dayIndex == 4 
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),
                Positioned(
                  top: 80,
                  left: 217,
                  //土曜日
                  child: dayIndex == 5 
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),
                Positioned(
                  top: 80,
                  left: 300,
                  //日曜日
                  child: dayIndex == 6 
                    ? hasNutrientData
                      ? (isDeficient ? const DeficientIcon() : const SatisfiedIcon())
                      : const DeficientIcon() // データがない場合は☆表示
                    : const DeficientIcon(), 
                ),


                Positioned(
                  top: 130,
                  left: 80,
                  child: Image.asset('images/abatar.png'), // ねこちゃん
                ),
                Positioned(
                  top: 430,
                  left: 50,
                  child: const DialogueBox(), // 吹き出し
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// 栄養不足がない場合のアイコン
class SatisfiedIcon extends StatelessWidget {
  const SatisfiedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: 70,
      color: Colors.green,
    );
  }
}

// 栄養不足がある場合のアイコン
class DeficientIcon extends StatelessWidget {
  const DeficientIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_outline,
      size: 70,
      color: Colors.red,
    );
  }
}

//デバッグ用（本番では）
class DeficientIcon_1 extends StatelessWidget {
  const DeficientIcon_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_outline,
      size: 70,
      color: Colors.blue,
    );
  }
}


class Display_Star extends StatelessWidget{
    const Display_Star({super.key});

      @override
  Widget build(BuildContext context) {
    return Stack();
  }
}
class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 吹き出しの背景を描画する
        CustomPaint(
          size: const Size(300, 150), // 吹き出しのサイズ
          painter: BalloonPainter(),
        ),
        // 吹き出しの中にテキストを表示する
        const Positioned(
          top: 30,
          left: 30,
          right: 30,
          //吹き出し内のコメント
          child: Text(
            '今日も１日お疲れさま！教えたいレシピがあるよ！',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class BalloonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill;

    final path = Path();

    // 吹き出しの三角形を上に移動
    path.moveTo(120, -20);  // 三角形の頂点
    path.lineTo(90, 0);    // 左側
    path.lineTo(110, 0);    // 右側
    path.close();          // 三角形を閉じる
    canvas.drawPath(path, paint);

    // 吹き出しの形（矩形と三角形の組み合わせ）
    path.moveTo(20, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(
      size.width, 0, size.width, 20);  // 右上の角の曲線
    path.lineTo(size.width, size.height - 30);
    path.quadraticBezierTo(size.width, size.height, size.width - 20, size.height);
    path.lineTo(60, size.height);
    
    // 三角形下の角
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.lineTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    // 描画
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
