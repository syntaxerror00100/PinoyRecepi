class RecipeMainIngredientsModel {
  int id;
  int recepiId;
  String name;
  String thumbNaimImageUrl;

  RecipeMainIngredientsModel.fromMap(Map<String, dynamic> map) {
    recepiId = map['RecepiId'];
    name = map['Name'];
    thumbNaimImageUrl = map['ThumbNaimImageUrl'];
    id = map['Id'];
  }
}
