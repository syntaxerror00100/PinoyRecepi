class RecipeTypeModel {
  int recepiId;
  String name;

  RecipeTypeModel.fromMap(Map<String, dynamic> map) {
    recepiId = map['RecepiId'];
    name = map['Name'];
  }
}
