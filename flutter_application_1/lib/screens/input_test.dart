import 'package:flutter/material.dart';

// ButtonScreenで表示するクラス
class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  List<String> recipeTitles = [
    'Recipe 1: Delicious Pancakes',
    'Recipe 2: Healthy Salad',
    'Recipe 3: Spaghetti Carbonara',
    'Recipe 4: Grilled Chicken',
    'Recipe 5: Chocolate Brownies',
  ];

  List<String> recipeContents = [
    '''Ingredients:
- Flour: 200g
- Eggs: 2
- Milk: 300ml
- Sugar: 50g
- Butter: 20g

Steps:
1. Mix flour and sugar in a bowl.
2. Beat the eggs and add them to the dry ingredients.
3. Gradually add milk and whisk until smooth.
4. Heat butter in a pan and cook the pancakes for 2-3 minutes on each side.
5. Serve with syrup or fruits.''',

    '''Ingredients:
- Lettuce: 100g
- Tomato: 50g
- Cucumber: 50g
- Olive Oil: 2 tbsp
- Salt: To taste

Steps:
1. Wash and chop the vegetables.
2. Toss them in a bowl with olive oil and salt.
3. Serve immediately.''',

    '''Ingredients:
- Spaghetti: 200g
- Eggs: 2
- Parmesan Cheese: 50g
- Bacon: 100g
- Black Pepper: To taste

Steps:
1. Cook spaghetti according to the package instructions.
2. Fry the bacon until crispy.
3. Beat the eggs and mix with grated Parmesan cheese.
4. Drain the spaghetti and combine with the egg mixture and bacon.
5. Season with black pepper and serve.''',

    '''Ingredients:
- Chicken Breast: 200g
- Olive Oil: 2 tbsp
- Salt: To taste
- Black Pepper: To taste

Steps:
1. Season the chicken with salt and pepper.
2. Heat the olive oil in a pan and grill the chicken for 5-7 minutes on each side.
3. Let it rest for a few minutes before serving.''',

    '''Ingredients:
- Dark Chocolate: 200g
- Butter: 100g
- Sugar: 150g
- Flour: 100g
- Eggs: 3

Steps:
1. Melt the chocolate and butter in a heatproof bowl over simmering water.
2. Stir in sugar, then add the eggs one by one.
3. Fold in the flour and mix until smooth.
4. Pour the batter into a baking tin and bake at 180°C for 25-30 minutes.
5. Let cool before cutting into squares.''',
  ];

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

void main() {
  runApp(const MaterialApp(
    home: ButtonScreen(),
  ));
}
