class RecipeTagsModel {
  int id;
  int recepiId;
  String label;
  String value;
  RecipeTagsModel({this.id, this.recepiId, this.label, this.value});

  RecipeTagsModel.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    recepiId = map['RecepiId'];
    label = map['Label'];
    value = map['value'];
  }
}
