import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ButtonScreenで表示するクラス
class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  List<String> recipeTitles = [];
  List<String> recipeContents = [];

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
      });
    } else {
      print('Failed to load recipes');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // 初期化時にAPIを呼び出す
  }

  @override
  Widget build(BuildContext context) {
    const CharacterImage='images/abatar.png';

    final comment=Container(
        margin: const EdgeInsets.only(left: 20.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text('''ぼくからのおすすめだよ！''',
          style: const TextStyle(color: Colors.white),
      ),
    );

    final TalkCharacter=Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          CharacterImage,
          width: 200,
          height:200 ,
        ),
        comment,
      ],
    );


    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Titles')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_sample.jpg'), // 背景画像を指定
            fit: BoxFit.cover, // 画像を画面全体に広げる
          ),
        ),
        child: Column(
          children: [
            Expanded( // ここでListView.builderを包む
              child: ListView.builder(
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
    const CharacterImage='images/abatar.png';

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
          children:[
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
          ]
        ),
      )
    );
  }
}
