import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataModel.dart';

Future<Nutrients?> fetchNutrients(int userId) async {
  final String apiUrl ='https://32a4-106-72-129-161.ngrok-free.app/';

  // GETリクエストをRails APIに送信
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    // レスポンスのJSONをデコードし、Nutrientsモデルに変換
    return Nutrients.fromJson(jsonDecode(response.body));
  } else {
    // エラーハンドリング
    print('Failed to load user data');
    return null;
  }
}