class RecepiMainIngredientsModel {
  int recepiId;
  String name;

  RecepiMainIngredientsModel.fromMap(Map<String, dynamic> map) {
    recepiId = map['RecepiId'];
    name = map['Name'];
  }
}
