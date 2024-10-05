import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ButtonScreenで表示するクラス
class CookScreen extends StatefulWidget {
  const CookScreen({super.key});

  @override
  _CookScreenState createState() => _CookScreenState();
}

class _CookScreenState extends State<CookScreen> {
  List<String> recipeTitles = [];
  List<String> recipeContents = [];
  bool isLoading = true; // ローディング状態を管理する変数

  // APIからレシピ情報を取得するメソッド
  Future<void> fetchRecipes() async {
    final response = await http.get(
      Uri.parse('https://your_api_url.com/recommend'), // APIのエンドポイント
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer your_access_token", // 認証が必要ならトークンを指定
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recipeTitles = List<String>.from(data['recipe_titles']); // レシピタイトルを取得
        recipeContents = List<String>.from(data['recipe_contents']); // レシピ詳細を取得
        isLoading = false; // データ取得完了
      });
    } else {
      print('Failed to load recipes');
      setState(() {
        isLoading = false; // エラー発生時もローディングを終了
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // 初期化時にAPIを呼び出す
  }

  @override
  Widget build(BuildContext context) {
    const CharacterImage = 'images/abatar.png';

    final comment = Container(
      margin: const EdgeInsets.only(left: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        '''ぼくからのおすすめだよ！''',
        style: const TextStyle(color: Colors.white),
        softWrap: true,
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
      appBar: AppBar(title: const Text('献立作成')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
            fit: BoxFit.cover, // 画像を画面全体に広げる
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: isLoading // ローディング状態の判定
                  ? Center(child: CircularProgressIndicator()) // ローディングインジケーターを表示
                  : ListView.builder(
                      itemCount: recipeTitles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // ボタンが押されたときに詳細画面に遷移
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                    title: recipeTitles[index],
                                    content: recipeContents[index],
                                  ),
                                ),
                              );
                            },
                            child: Text(recipeTitles[index]), // ボタンにレシピのタイトルを表示
                          ),
                        );
                      },
                    ),
            ),
            TalkCharacter,
          ],
        ),
      ),
    );
  }
}

// 詳細画面を表示するクラス
class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const RecipeDetailScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        // 画面全体のサイズを取得
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
            fit: BoxFit.cover, // 背景画像を画面全体に広げる
          ),
        ),
        // テキスト部分をスクロール可能にする
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content, // レシピの内容を表示
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
