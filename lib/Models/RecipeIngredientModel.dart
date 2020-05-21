class RecipeIngredientModel {
  int id;
  int recepiId;
  String ingredient;

  RecipeIngredientModel({this.id, this.recepiId, this.ingredient});

  RecipeIngredientModel.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    recepiId = map['RecepiId'];
    ingredient = map['Ingredient'];
  }
}
