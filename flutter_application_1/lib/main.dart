import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/screens/nutritional_management/management.dart';
import 'package:flutter_application_1/screens/pageB.dart';
import 'package:flutter_application_1/screens/login.dart'; 
import 'package:flutter_application_1/screens/home.dart'; 

void main() {
  const app = MaterialApp(home: Root());

  // プロバイダーでアプリを囲む
  const scope = ProviderScope(child: app);

  runApp(scope);
}

// プロバイダー
final indexProvider = StateProvider((ref) {
  return 2;
});

// ルートウィジェット (ConsumerWidget)
class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログインしていなければログイン画面を表示
    final isLoggedIn = ref.watch(loginStateProvider); // ログイン状態を監視
    return isLoggedIn ? const HomeScreen() : const HomeScreen(); // 状態に応じて表示を変更
  }
}

// ログイン状態を管理するプロバイダー
final loginStateProvider = StateProvider((ref) => false);

// ホーム画面
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // インデックス
    final index = ref.watch(indexProvider);

    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.restaurant),
        label: '献立',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.edit_square),
        label: '記録',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'ホーム',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.timeline),
        label: '栄養管理',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'アカウント',
      ),
    ];

    final bar = BottomNavigationBar(
      items: items,
      backgroundColor: const Color.fromARGB(255, 234, 255, 193),
      selectedItemColor: const Color.fromARGB(255, 255, 181, 71),
      unselectedItemColor: const Color.fromARGB(255, 29, 52, 127),
      currentIndex: index,
      onTap: (index) {
        // タップ時にインデックスを変更
        ref.read(indexProvider.notifier).state = index;
      },
    );

    const pages = [
      CookScreen(),
      PageB(),
      Home(),
      Management(),
      PageB(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }
}
