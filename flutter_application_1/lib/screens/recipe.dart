import 'package:flutter/material.dart';

//献立提示とレシピ表示
/// 馬のモデルクラス
class Recipe {
  // 名前
  final String name;

  // コンストラクタ
  Recipe(this.name);
}

/// カードにしたいモデルたち
final models = [
  Recipe('ナリタブライアン'),
  Recipe('スペシャルウィーク'),
  Recipe('オグリキャップ'),
  Recipe('サイレンススズカ'),
  Recipe('トウカイテイオー'),
];

/// 馬のカード Widget
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.model,
  });
  // データが入ったモデル
  final  Recipe model;

  @override
  Widget build(BuildContext context) {
  
    // 名前
    final text = Text(
      model.name,
      style: const TextStyle(fontSize: 20),
    );

    // 画像と名前を縦に並べる
    final imgAndText = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        text,
      ],
    );

    // カード部分を作るコンテナ
    return Container(
      decoration: BoxDecoration(
        // 色
        color: const Color.fromARGB(255, 255, 247, 210),
        // 角丸
        borderRadius: BorderRadius.circular(20),
        // 影
        boxShadow: [
          BoxShadow(
            // 影の設定
            color: Colors.black.withOpacity(0.2), //色
            spreadRadius: 2, // 広がりの大きさ
            blurRadius: 2, // ぼかしの強さ
            offset: const Offset(0, 2), // 方向
          ),
        ],
      ),
      child: imgAndText,
    );
  }
}

// モデル => ウィジェット に変換する関数
Widget modelToWidget(Recipe model) {
  // ページの部分
  return Container(
    // カードの周りに 10 ずつスペースを空ける
    padding: const EdgeInsets.fromLTRB(10,100,10,250),
    // 中身は カード
    child: RecipeCard(model: model),
  );
  // カードを使う
}

// ホーム画面
class Cook extends StatelessWidget {
  const Cook({super.key});

  @override
  Widget build(BuildContext context) {
    // カルーセル
    final carousel = PageView.builder(
      // カルーセルのコントローラー
      controller: PageController(
        // 左右のカードがどのくらい見えるかのバランスを決める
        viewportFraction: 0.8,
      ),
      // カードの数 = モデルの数
      itemCount: models.length,
      // モデルをWidgetに変換する関数
      itemBuilder: (c, i) => modelToWidget(models[i]),
    );

    // 画面
    return Scaffold(
      // 真ん中
      body: Align(
        alignment: Alignment.topCenter,
        // 横長のコンテナ
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_sample.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: carousel,
        ),
      ),
    );
  }
}