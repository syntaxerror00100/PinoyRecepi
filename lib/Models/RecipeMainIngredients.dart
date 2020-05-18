class RecipeMainIngredientsModel {
  int recepiId;
  String name;

  RecipeMainIngredientsModel.fromMap(Map<String, dynamic> map) {
    recepiId = map['RecepiId'];
    name = map['Name'];
  }
}
