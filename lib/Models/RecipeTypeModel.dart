class RecipeTypeModel {
  int recepiId;
  String name;
  String thumbNaimImageUrl;

  RecipeTypeModel.fromMap(Map<String, dynamic> map) {
    recepiId = map['RecepiId'];
    name = map['Name'];
    thumbNaimImageUrl = map['ThumbNaimImageUrl'];
  }
}
