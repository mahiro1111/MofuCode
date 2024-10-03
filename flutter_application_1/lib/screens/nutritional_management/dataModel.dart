class Nutrients {
  final double protein;
  final double carbohydrate;
  final double lipid;

  Nutrients({required this.protein, required this.carbohydrate, required this.lipid});

  // JSONからNutrientsオブジェクトを作成する
  factory Nutrients.fromJson(Map<String, dynamic> json) {
    return Nutrients(
      protein: json['protein'],
      carbohydrate: json['carbohydrate'],
      lipid: json['lipid'],
    );
  }
}