class RecipeNutritionModel {
  int id;
  int recepiId;
  String value;
  String label;

  RecipeNutritionModel({this.id, this.recepiId, this.value, this.label});

  RecipeNutritionModel.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    recepiId = map['RecepiId'];
    value = map['Balue'];
    label = map['Label'];
  }
}
